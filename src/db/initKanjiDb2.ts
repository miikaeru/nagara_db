import { readFileSync } from 'fs';
import { join } from 'path';

import type { PrismaClient } from '@prisma/client'
import { SingleBar } from 'cli-progress';

import { Kanjidic2 } from '../kanjidic2/model';
import { cyan } from 'ansi-colors';

const path = join(__dirname, '..', '..', 'output/kanjidic2.json');
const file = readFileSync(path);
const data = JSON.parse(file.toString()) as Kanjidic2;

export async function initKanjiDb(prisma: PrismaClient) {
    console.log(cyan('Initializing Kanji tables'));
    await initK1Db(prisma);
    await initK2Db(prisma);
    await initK3Db(prisma);
}

//
// Create Kanji 1st level entries
//
async function initK1Db(prisma: PrismaClient) {

    const progress = new SingleBar({
        format: 'Creating kanji 1st level entries |' + '{bar}' + '| {percentage}% || {value}/{total} entries',
        barCompleteChar: '\u2588',
        barIncompleteChar: '\u2591',
        hideCursor: true
    });

    progress.start(data.character.length, 0);

    for (const entry of data.character) {
        progress.increment();

        await prisma.kanji.upsert({
            where: {
                literal: entry.literal
            },
            update: {
                literal: entry.literal,
            },
            create: {
                literal: entry.literal
            }
        });
    }

    progress.stop();
}

//
// Create Kanji 1st level entries
//
async function initK2Db(prisma: PrismaClient) {

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

    const progress = new SingleBar({
        format: 'Creating kanji 2nd level entries |' + '{bar}' + '| {percentage}% || {value}/{total} entries',
        barCompleteChar: '\u2588',
        barIncompleteChar: '\u2591',
        hideCursor: true
    });

    progress.start(data.character.length, 0);

    for (const entry of data.character) {

        progress.increment();

        const kanji_id = kanji.find(a => a.literal === entry.literal)?.id;

        if (kanji_id) {

            // Create codepoint data
            for (const cp_value of entry.codepoint.cp_value) {
                const kwCodePointType = kwCodepointTypeEntries.find(a => a.value === cp_value.cp_type);

                if (kwCodePointType) {
                    await prisma.kanji_Codepoint.create({
                        data: {
                            kanji_id: kanji_id,
                            kw_codepoint_id: kwCodePointType.id,
                            value: cp_value.value
                        }
                    })
                }
            }

            // Create misc data
            const strokeCountArr = Array.isArray(entry.misc.stroke_count) ? entry.misc.stroke_count : [entry.misc.stroke_count];
            const kwStrokeCount = kwStrokeCountEntries.find(a => a.value === strokeCountArr[0]);
            const kwGrade = kwGradeEntries.find(a => a.value === entry.misc.grade);
            const kwJLPT = kwJLPTEntries.find(a => a.value === entry.misc.jlpt);

            if (kwStrokeCount) {
                await prisma.kanji_Misc.create({
                    data: {
                        kanji_id: kanji_id,
                        strokeCount_id: kwStrokeCount.id,
                        freq: entry.misc.freq ? +entry.misc.freq : null,
                        grade_id: kwGrade ? kwGrade.id : null,
                        jlpt_id: kwJLPT ? kwJLPT.id : null,
                    }
                });
            }

            // Create dic ref data
            if (entry.dic_number) {
                const dicRefArr = Array.isArray(entry.dic_number.dic_ref) ? entry.dic_number.dic_ref : [entry.dic_number.dic_ref];

                for (const dicRef of dicRefArr) {

                    const kwDicRefType = kwDicRefTypeEntries.find(a => a.value === dicRef.dr_type);
                    const kwMorohashiVol = kwMorohashiVolEntries.find(a => a.value === dicRef.m_vol);

                    if (kwDicRefType) {

                        await prisma.kanji_DicRef.create({
                            data: {
                                kanji_id: kanji_id,
                                kwDicRefType_id: kwDicRefType.id,
                                value: dicRef.value,
                                kwMorohashiVol_id: kwMorohashiVol ? kwMorohashiVol.id : null,
                                mPage: dicRef.m_page ? +dicRef.m_page : null
                            }
                        });
                    }
                }
            }

            // Create query code data
            if (entry.query_code) {
                const query_codeArr = Array.isArray(entry.query_code.q_code) ? entry.query_code.q_code : [entry.query_code.q_code];

                for (const query_code of query_codeArr) {
                    const kwQueryCodeType = kwQueryCodeTypeEntries.find(a => a.value === query_code.qc_type);
                    const kwSkipMisclass = kwSkipMisclassEntries.find(a => a.value === query_code.skip_misclass);

                    if (kwQueryCodeType) {
                        await prisma.kanji_QueryCode.create({
                            data: {
                                kanji_id: kanji_id,
                                kwQueryCodeType_id: kwQueryCodeType.id,
                                kwSkipMisclass_id: kwSkipMisclass ? kwSkipMisclass.id : null,
                                value: query_code.value
                            }
                        });
                    }
                }
            }

            // Create reading data
            if (entry.reading_meaning?.rmgroup?.reading) {
                const readingArr = Array.isArray(entry.reading_meaning.rmgroup.reading) ? entry.reading_meaning.rmgroup.reading : [entry.reading_meaning.rmgroup.reading];

                for (const reading of readingArr) {
                    const kwKanjiReadingType = kwKanjiReadingTypeEntries.find(a => a.value === reading.r_type);

                    if (kwKanjiReadingType) {

                        await prisma.kanji_Reading.create({
                            data: {
                                kanji_id: kanji_id,
                                kwKanjiReadingType_id: kwKanjiReadingType.id,
                                value: reading.value
                            }
                        })
                    }
                }
            }

            // Create meaning data
            if (entry.reading_meaning?.rmgroup?.meaning) {
                const meaningArr = Array.isArray(entry.reading_meaning.rmgroup.meaning) ? entry.reading_meaning.rmgroup.meaning : [entry.reading_meaning.rmgroup.meaning];

                for (const meaning of meaningArr) {
                    if (typeof meaning === "string") {
                        const kwLang = kwLangEntries.find(a => a.value === "en");

                        if (kwLang) {
                            await prisma.kanji_Meaning.create({
                                data: {
                                    kanji_id: kanji_id,
                                    kwLang_id: kwLang.id,
                                    value: meaning
                                }
                            });
                        }
                    } else {
                        const kwLang = kwLangEntries.find(a => a.value === meaning.m_lang);

                        if (kwLang) {
                            await prisma.kanji_Meaning.create({
                                data: {
                                    kanji_id: kanji_id,
                                    kwLang_id: kwLang.id,
                                    value: meaning.value
                                }
                            });
                        }
                    }
                }
            }

            // Create nanori data
            if (entry.reading_meaning?.nanori) {
                const nanoriArr = Array.isArray(entry.reading_meaning.nanori) ? entry.reading_meaning.nanori : [entry.reading_meaning.nanori];

                for (const nanori of nanoriArr) {
                    await prisma.kanji_Nanori.create({
                        data: {
                            kanji_id: kanji_id,
                            value: nanori
                        }
                    });
                }
            }
        }
    };

    progress.stop();
}

//
// Create Kanji 3rd level entries
//
async function initK3Db(prisma: PrismaClient) {

    const progress = new SingleBar({
        format: 'Creating kanji 3rd level entries |' + '{bar}' + '| {percentage}% || {value}/{total} entries',
        barCompleteChar: '\u2588',
        barIncompleteChar: '\u2591',
        hideCursor: true
    });

    progress.start(data.character.length, 0);

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

    for (const entry of data.character) {

        progress.increment();

        if (entry.misc.variant) {
            const kanji = kanjiEntries.find(a => a.literal === entry.literal);

            if (kanji && kanji.misc?.id) {

                const misc_id = kanji.misc.id;
                const variants = Array.isArray(entry.misc.variant) ? entry.misc.variant : [entry.misc.variant];

                for (const variant of variants) {
                    const kanjiVariant = kanjiEntries.find(a => a.codepoint.find(b => b.type.value === variant.var_type && b.value === variant.value));

                    if (kanjiVariant) {
                        await prisma.kanji_Misc_Variant.create({
                            data: {
                                kanjiMisc_id: misc_id,
                                kanji_id: kanjiVariant.id
                            }
                        });
                    }
                }
            }
        }
    }

    progress.stop();
}