import type { PrismaClient } from '@prisma/client'

export async function deleteAllEntries(prisma: PrismaClient) {

    await prisma.kanji_Misc_Variant.deleteMany();

    await prisma.kanji_Codepoint.deleteMany();
    await prisma.kanji_DicRef.deleteMany();
    await prisma.kanji_Meaning.deleteMany();
    await prisma.kanji_Misc.deleteMany();
    await prisma.kanji_Nanori.deleteMany();
    await prisma.kanji_QueryCode.deleteMany();
    await prisma.kanji_Radical.deleteMany();
    await prisma.kanji_Reading.deleteMany();

    await prisma.kanji.deleteMany();

    await prisma.kwCodepointType.deleteMany();
    await prisma.kwDicRefType.deleteMany();
    await prisma.kwGrade.deleteMany();
    await prisma.kwJLPT.deleteMany();
    await prisma.kwKanjiReadingType.deleteMany();
    await prisma.kwLang.deleteMany();
    await prisma.kwMorohashiVol.deleteMany();
    await prisma.kwQueryCodeType.deleteMany();
    await prisma.kwRadicalType.deleteMany();
    await prisma.kwSkipMisclass.deleteMany();
    await prisma.kwStrokeCount.deleteMany();

}