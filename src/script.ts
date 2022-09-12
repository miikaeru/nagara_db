import { PrismaClient } from '@prisma/client';

import { initKwDb } from './db/initKwDb';
import { initKanjiDb } from './db/initKanjiDb';
import { green } from 'ansi-colors';

const prisma = new PrismaClient()

async function main() {

    await initKwDb(prisma);
    await initKanjiDb(prisma);

    console.log(green('Finished'))

    const asdf = await prisma.kanji.findUnique({
        where: {
            literal: "愛",
        },
        include: {
            codepoint: true,
            dic_ref: true,
            meaning: true,
            misc: {
                include: {
                    grade: true,
                    jlpt: true,
                    rad_name: true,
                    strokeCount: true,
                }
            },
            nanori: true,
            query_code: true,
            reading: true,
            variant: true
        }
    });
    console.log(asdf);
}

main()
    .then(async () => {
        await prisma.$disconnect()
    })
    .catch(async (e) => {
        console.error(e)
        await prisma.$disconnect()
        process.exit(1)
    })