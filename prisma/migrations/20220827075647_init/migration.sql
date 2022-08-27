-- CreateTable
CREATE TABLE "Kanji" (
    "id" SERIAL NOT NULL,
    "literal" TEXT NOT NULL,

    CONSTRAINT "Kanji_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Radical" (
    "id" SERIAL NOT NULL,
    "radical_id" INTEGER,
    "sequence" INTEGER NOT NULL,
    "literal" TEXT NOT NULL,

    CONSTRAINT "Radical_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Codepoint" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kw_codepoint_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_Codepoint_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Radical" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "type_id" INTEGER,
    "radical_id" INTEGER NOT NULL,

    CONSTRAINT "Kanji_Radical_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Misc" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "grade_id" INTEGER,
    "strokeCount_id" INTEGER NOT NULL,
    "jlpt_id" INTEGER,
    "freq" INTEGER,

    CONSTRAINT "Kanji_Misc_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_DicRef" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kwDicRefType_id" INTEGER NOT NULL,
    "kwMorohashiVol_id" INTEGER,
    "mPage" INTEGER,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_DicRef_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_QueryCode" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kwQueryCodeType_id" INTEGER NOT NULL,
    "kwSkipMisclass_id" INTEGER,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_QueryCode_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Reading" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kwKanjiReadingType_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_Reading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Meaning" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kwLang_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_Meaning_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Nanori" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_Nanori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Misc_Variant" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kanjiMisc_id" INTEGER NOT NULL,

    CONSTRAINT "Kanji_Misc_Variant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Kanji_Misc_RadName" (
    "id" SERIAL NOT NULL,
    "kanjiMisc_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "Kanji_Misc_RadName_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwCodepointType" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwCodepointType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwRadicalType" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwRadicalType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwGrade" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwGrade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwStrokeCount" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwStrokeCount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwJLPT" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwJLPT_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwDicRefType" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwDicRefType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwMorohashiVol" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwMorohashiVol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwQueryCodeType" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwQueryCodeType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwSkipMisclass" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwSkipMisclass_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwKanjiReadingType" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwKanjiReadingType_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KwLang" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "KwLang_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Kanji_literal_key" ON "Kanji"("literal");

-- CreateIndex
CREATE UNIQUE INDEX "Radical_literal_key" ON "Radical"("literal");

-- CreateIndex
CREATE UNIQUE INDEX "Kanji_Misc_kanji_id_key" ON "Kanji_Misc"("kanji_id");

-- CreateIndex
CREATE UNIQUE INDEX "KwCodepointType_value_key" ON "KwCodepointType"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwRadicalType_value_key" ON "KwRadicalType"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwGrade_value_key" ON "KwGrade"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwStrokeCount_value_key" ON "KwStrokeCount"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwJLPT_value_key" ON "KwJLPT"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwDicRefType_value_key" ON "KwDicRefType"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwMorohashiVol_value_key" ON "KwMorohashiVol"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwQueryCodeType_value_key" ON "KwQueryCodeType"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwSkipMisclass_value_key" ON "KwSkipMisclass"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwKanjiReadingType_value_key" ON "KwKanjiReadingType"("value");

-- CreateIndex
CREATE UNIQUE INDEX "KwLang_value_key" ON "KwLang"("value");

-- AddForeignKey
ALTER TABLE "Radical" ADD CONSTRAINT "Radical_radical_id_fkey" FOREIGN KEY ("radical_id") REFERENCES "Radical"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Codepoint" ADD CONSTRAINT "Kanji_Codepoint_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Codepoint" ADD CONSTRAINT "Kanji_Codepoint_kw_codepoint_id_fkey" FOREIGN KEY ("kw_codepoint_id") REFERENCES "KwCodepointType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Radical" ADD CONSTRAINT "Kanji_Radical_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Radical" ADD CONSTRAINT "Kanji_Radical_type_id_fkey" FOREIGN KEY ("type_id") REFERENCES "KwRadicalType"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Radical" ADD CONSTRAINT "Kanji_Radical_radical_id_fkey" FOREIGN KEY ("radical_id") REFERENCES "Radical"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc" ADD CONSTRAINT "Kanji_Misc_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc" ADD CONSTRAINT "Kanji_Misc_grade_id_fkey" FOREIGN KEY ("grade_id") REFERENCES "KwGrade"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc" ADD CONSTRAINT "Kanji_Misc_strokeCount_id_fkey" FOREIGN KEY ("strokeCount_id") REFERENCES "KwStrokeCount"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc" ADD CONSTRAINT "Kanji_Misc_jlpt_id_fkey" FOREIGN KEY ("jlpt_id") REFERENCES "KwJLPT"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_DicRef" ADD CONSTRAINT "Kanji_DicRef_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_DicRef" ADD CONSTRAINT "Kanji_DicRef_kwDicRefType_id_fkey" FOREIGN KEY ("kwDicRefType_id") REFERENCES "KwDicRefType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_DicRef" ADD CONSTRAINT "Kanji_DicRef_kwMorohashiVol_id_fkey" FOREIGN KEY ("kwMorohashiVol_id") REFERENCES "KwMorohashiVol"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_QueryCode" ADD CONSTRAINT "Kanji_QueryCode_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_QueryCode" ADD CONSTRAINT "Kanji_QueryCode_kwQueryCodeType_id_fkey" FOREIGN KEY ("kwQueryCodeType_id") REFERENCES "KwQueryCodeType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_QueryCode" ADD CONSTRAINT "Kanji_QueryCode_kwSkipMisclass_id_fkey" FOREIGN KEY ("kwSkipMisclass_id") REFERENCES "KwSkipMisclass"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Reading" ADD CONSTRAINT "Kanji_Reading_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Reading" ADD CONSTRAINT "Kanji_Reading_kwKanjiReadingType_id_fkey" FOREIGN KEY ("kwKanjiReadingType_id") REFERENCES "KwKanjiReadingType"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Meaning" ADD CONSTRAINT "Kanji_Meaning_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Meaning" ADD CONSTRAINT "Kanji_Meaning_kwLang_id_fkey" FOREIGN KEY ("kwLang_id") REFERENCES "KwLang"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Nanori" ADD CONSTRAINT "Kanji_Nanori_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc_Variant" ADD CONSTRAINT "Kanji_Misc_Variant_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "Kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc_Variant" ADD CONSTRAINT "Kanji_Misc_Variant_kanjiMisc_id_fkey" FOREIGN KEY ("kanjiMisc_id") REFERENCES "Kanji_Misc"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Kanji_Misc_RadName" ADD CONSTRAINT "Kanji_Misc_RadName_kanjiMisc_id_fkey" FOREIGN KEY ("kanjiMisc_id") REFERENCES "Kanji_Misc"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
