import { PrismaClient } from '@prisma/client';

import { deleteAllEntries } from './db/deleteDb';
import { initKanjiKwDb } from './db/initKwDb';
import { initFirstLevelDb, initSecondLevelDb, initThirdLevelMiscDb } from './db/initDb';

const prisma = new PrismaClient()

async function main() {

    await deleteAllEntries(prisma);
    await initKanjiKwDb(prisma);
    await initFirstLevelDb(prisma);
    await initSecondLevelDb(prisma);
    await initThirdLevelMiscDb(prisma);
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