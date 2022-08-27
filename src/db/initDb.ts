import { readFileSync } from 'fs';
import { join } from 'path';

import type { Prisma, PrismaClient } from '@prisma/client'

import { Kanjidic2 } from '../kanjidic2/model';

const inputFilePath = join(__dirname, '..', '..', 'output/kanjidic2.json');
const file = readFileSync(inputFilePath);
const data = JSON.parse(file.toString()) as Kanjidic2;

export async function initFirstLevelDb(prisma: PrismaClient) {

    await prisma.kanji.createMany({
        data: data.character.map(v => ({ literal: v.literal }))
    });
}

export async function initSecondLevelDb(prisma: PrismaClient) {

    const kwCodepointTypeEntries = await prisma.kwCodepointType.findMany();
    const kwDicRefTypeEntries = await prisma.kwDicRefType.findMany();
    const kwGradeEntries = await prisma.kwGrade.findMany();
    const kwJLPTEntries = await prisma.kwJLPT.findMany();
    const kwKanjiReadingTypeEntries = await prisma.kwKanjiReadingType.findMany();
    const kwLangEntries = await prisma.kwLang.findMany();
    const kwMorohashiVolEntries = await prisma.kwMorohashiVol.findMany();
    const kwQueryCodeTypeEntries = await prisma.kwQueryCodeType.findMany();
    const kwSkipMisclassEntries = await prisma.kwSkipMisclass.findMany();
    const kwStrokeCountEntries = await prisma.kwStrokeCount.findMany();

    const kanji = await prisma.kanji.findMany();

    const kanjiCodepointData: Prisma.Kanji_CodepointCreateManyInput[] = [];
    const kanjiReadingData: Prisma.Kanji_ReadingCreateManyInput[] = [];
    const kanjiMiscData: Prisma.Kanji_MiscCreateManyInput[] = [];
    const kanjiDicRefData: Prisma.Kanji_DicRefCreateManyInput[] = [];
    const kanjiQueryCodeData: Prisma.Kanji_QueryCodeCreateManyInput[] = [];
    const kanjiMeaningData: Prisma.Kanji_MeaningCreateManyInput[] = [];
    const kanjiNanoriData: Prisma.Kanji_NanoriCreateManyInput[] = [];

    data.character.forEach(character => {

        const kanji_id = kanji.find(a => a.literal === character.literal)?.id;

        if (kanji_id) {

            // Create codepoint data
            character.codepoint.cp_value.forEach(cp_value => {
                const kwCodePointType_id = kwCodepointTypeEntries.find(a => a.value === cp_value.cp_type)?.id;

                if (kwCodePointType_id) {
                    kanjiCodepointData.push({
                        kanji_id: kanji_id,
                        kw_codepoint_id: kwCodePointType_id,
                        value: cp_value.value
                    });
                }
            });

            // Create misc data
            const strokeCountArr = Array.isArray(character.misc.stroke_count) ? character.misc.stroke_count : [character.misc.stroke_count];
            const kwStrokeCount_id = kwStrokeCountEntries.find(a => a.value === strokeCountArr[0])?.id;

            const kwGrade_id = kwGradeEntries.find(a => a.value === character.misc.grade)?.id;
            const jlpt_id = kwJLPTEntries.find(a => a.value === character.misc.jlpt)?.id;

            if (kwStrokeCount_id) {
                kanjiMiscData.push({
                    kanji_id: kanji_id,
                    strokeCount_id: kwStrokeCount_id,
                    freq: character.misc.freq ? +character.misc.freq : null,
                    grade_id: kwGrade_id ? kwGrade_id : null,
                    jlpt_id: jlpt_id ? jlpt_id : null,
                })
            }

            // Create dic ref data
            if (character.dic_number) {
                const dicRefArr = Array.isArray(character.dic_number.dic_ref) ? character.dic_number.dic_ref : [character.dic_number.dic_ref];

                dicRefArr.forEach(dicRef => {

                    const kwDicRefType_id = kwDicRefTypeEntries.find(a => a.value === dicRef.dr_type)?.id;
                    const kwMorohashiVol_id = kwMorohashiVolEntries.find(a => a.value === dicRef.m_vol)?.id;

                    if (kwDicRefType_id) {
                        kanjiDicRefData.push({
                            kanji_id: kanji_id,
                            kwDicRefType_id: kwDicRefType_id,
                            value: dicRef.value,
                            kwMorohashiVol_id: kwMorohashiVol_id,
                            mPage: dicRef.m_page ? +dicRef.m_page : null
                        });
                    }
                });
            }

            // Create query code data
            if (character.query_code) {
                const queryCodeArr = Array.isArray(character.query_code.q_code) ? character.query_code.q_code : [character.query_code.q_code];

                queryCodeArr.forEach(queryCode => {

                    const kwQueryCodeType_id = kwQueryCodeTypeEntries.find(a => a.value === queryCode.qc_type)?.id;
                    const kwSkipMisclass_id = kwSkipMisclassEntries.find(a => a.value === queryCode.skip_misclass)?.id;

                    if (kwQueryCodeType_id) {
                        kanjiQueryCodeData.push({
                            kanji_id: kanji_id,
                            kwQueryCodeType_id: kwQueryCodeType_id,
                            kwSkipMisclass_id: kwSkipMisclass_id ? kwSkipMisclass_id : null,
                            value: queryCode.value
                        })
                    }
                });
            }

            // Create reading data
            if (character.reading_meaning?.rmgroup?.reading) {
                const readingArr = Array.isArray(character.reading_meaning.rmgroup.reading) ? character.reading_meaning.rmgroup.reading : [character.reading_meaning.rmgroup.reading];

                readingArr.forEach(reading => {

                    const kwKanjiReadingType_id = kwKanjiReadingTypeEntries.find(a => a.value === reading.r_type)?.id;

                    if (kwKanjiReadingType_id) {
                        kanjiReadingData.push({
                            kanji_id: kanji_id,
                            kwKanjiReadingType_id: kwKanjiReadingType_id,
                            value: reading.value
                        });
                    }
                });
            }

            // Create meaning data
            if (character.reading_meaning?.rmgroup?.meaning) {
                const meaningArr = Array.isArray(character.reading_meaning.rmgroup.meaning) ? character.reading_meaning.rmgroup.meaning : [character.reading_meaning.rmgroup.meaning];

                meaningArr.forEach(meaning => {

                    if (typeof meaning === "string") {
                        const kwLang_id = kwLangEntries.find(a => a.value === "en")?.id;
                        if (kwLang_id)
                            kanjiMeaningData.push({
                                kanji_id: kanji_id,
                                kwLang_id: kwLang_id,
                                value: meaning
                            });
                    } else {
                        const kwLang_id = kwLangEntries.find(a => a.value === meaning.m_lang)?.id;
                        if (kwLang_id)
                            kanjiMeaningData.push({
                                kanji_id: kanji_id,
                                kwLang_id: kwLang_id,
                                value: meaning.value
                            });
                    }
                });
            }

            // Create nanori data
            if (character.reading_meaning?.nanori) {
                const nanoriArr = Array.isArray(character.reading_meaning.nanori) ? character.reading_meaning.nanori : [character.reading_meaning.nanori];

                nanoriArr.forEach(nanori => {

                    kanjiNanoriData.push({
                        kanji_id: kanji_id,
                        value: nanori
                    });
                });
            }

        }
    });

    await prisma.kanji_Codepoint.createMany({
        data: kanjiCodepointData
    });

    await prisma.kanji_Misc.createMany({
        data: kanjiMiscData
    });

    await prisma.kanji_DicRef.createMany({
        data: kanjiDicRefData
    });

    await prisma.kanji_QueryCode.createMany({
        data: kanjiQueryCodeData
    });

    await prisma.kanji_Reading.createMany({
        data: kanjiReadingData
    });

    await prisma.kanji_Meaning.createMany({
        data: kanjiMeaningData
    });

    await prisma.kanji_Nanori.createMany({
        data: kanjiNanoriData
    });
}

export async function initThirdLevelMiscDb(prisma: PrismaClient) {

    const kanjiMiscVariantData: Prisma.Kanji_Misc_VariantCreateManyInput[] = [];

    const kanjiEntries = await prisma.kanji.findMany({
        include: {
            misc: true,
            codepoint: {
                include: {
                    type: true
                }
            }
        }
    });

    data.character.forEach(character => {

        if (character.misc.variant) {
            const kanji = kanjiEntries.find(a => a.literal === character.literal);

            if (kanji && kanji.misc?.id) {

                const misc_id = kanji.misc.id;

                const variants = Array.isArray(character.misc.variant) ? character.misc.variant : [character.misc.variant];

                variants.forEach(variant => {

                    const kanjiVariant = kanjiEntries.find(a => a.codepoint.find(b => b.type.value === variant.var_type && b.value === variant.value));

                    if (kanjiVariant) {
                        kanjiMiscVariantData.push({
                            kanjiMisc_id: misc_id,
                            kanji_id: kanjiVariant.id
                        })
                    }
                });
            }
        }
    });

    await prisma.kanji_Misc_Variant.createMany({
        data: kanjiMiscVariantData
    });
}