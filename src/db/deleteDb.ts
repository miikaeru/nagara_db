import type { PrismaClient } from '@prisma/client'
import { SingleBar } from 'cli-progress';
import { red } from 'ansi-colors';

export async function deleteAllEntries(prisma: PrismaClient) {

    console.log(red('Deleting entries'))

    await prisma.kanji.deleteMany().then(v => {
        console.log(`Deleted ${v.count.toString()} Kanji entries`);
    });

    await prisma.kwCodepointType.deleteMany();

    await prisma.kwDial.deleteMany();

    await prisma.kwDicRefType.deleteMany();

    await prisma.kwGrade.deleteMany();

    await prisma.kwGlossType.deleteMany();

    await prisma.kwJLPT.deleteMany();

    await prisma.kwKanjiReadingType.deleteMany();

    await prisma.kwLang.deleteMany();

    await prisma.kwMorohashiVol.deleteMany();

    await prisma.kwQueryCodeType.deleteMany();

    await prisma.kwRadicalType.deleteMany();

    await prisma.kwSkipMisclass.deleteMany();

    await prisma.kwStrokeCount.deleteMany();

    await prisma.kwWordField.deleteMany();

    await prisma.kwWordKanjiInfo.deleteMany();

    await prisma.kwWordMisc.deleteMany();

    await prisma.kwWordPos.deleteMany();

    await prisma.kwWordPrio.deleteMany();

    await prisma.kwWordReadingInfo.deleteMany();
}