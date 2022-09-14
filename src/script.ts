import { PrismaClient } from '@prisma/client';
import { green } from 'ansi-colors';

import { initKanjiDb } from './db/initKanjiDb';
import { initKwDb } from './db/initKwDb';

const prisma = new PrismaClient()

async function main() {

    await initKwDb(prisma);
    await initKanjiDb(prisma);
    console.log(green('Finished'))

    const asdf = await prisma.kanji.findUnique({
        where: {
            literal: "右",
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
            variant: true,
            antonym: {
                include: {
                    kanji: true
                }
            },
            lookalike: {
                include: {
                    kanji: true
                }
            },
            synonym: {
                include: {
                    kanji: true
                }
            }
        }
    });
    console.log(JSON.stringify(asdf));
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