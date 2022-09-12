-- CreateTable
CREATE TABLE "kanji" (
    "id" SERIAL NOT NULL,
    "literal" TEXT NOT NULL,

    CONSTRAINT "kanji_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kanji.codepoint" (
    "kanji_id" INTEGER NOT NULL,
    "kw_codepoint_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.codepoint_pkey" PRIMARY KEY ("kanji_id","kw_codepoint_id")
);

-- CreateTable
CREATE TABLE "kanji.misc" (
    "kanji_id" INTEGER NOT NULL,
    "grade_id" INTEGER,
    "strokeCount_id" INTEGER NOT NULL,
    "jlpt_id" INTEGER,
    "freq" INTEGER,

    CONSTRAINT "kanji.misc_pkey" PRIMARY KEY ("kanji_id")
);

-- CreateTable
CREATE TABLE "kanji.dicref" (
    "kanji_id" INTEGER NOT NULL,
    "kwDicRefType_id" INTEGER NOT NULL,
    "kwMorohashiVol_id" INTEGER,
    "mPage" INTEGER,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.dicref_pkey" PRIMARY KEY ("kanji_id","kwDicRefType_id")
);

-- CreateTable
CREATE TABLE "kanji.querycode" (
    "kanji_id" INTEGER NOT NULL,
    "kwQueryCodeType_id" INTEGER NOT NULL,
    "kwSkipMisclass_id" INTEGER,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.querycode_pkey" PRIMARY KEY ("kanji_id","kwQueryCodeType_id")
);

-- CreateTable
CREATE TABLE "kanji.reading" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kwKanjiReadingType_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.reading_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kanji.meaning" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kwLang_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.meaning_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kanji.nanori" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.nanori_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kanji.variant" (
    "id" SERIAL NOT NULL,
    "kanji_id" INTEGER NOT NULL,
    "kanji_variant_id" INTEGER NOT NULL,

    CONSTRAINT "kanji.variant_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kanji.misc.rad" (
    "id" SERIAL NOT NULL,
    "kanjiMisc_id" INTEGER NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kanji.misc.rad_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.codepointtype" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.codepointtype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.radicaltype" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.radicaltype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.grade" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.grade_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.strokecount" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.strokecount_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.jlpt" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.jlpt_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.dicref" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.dicref_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.morohashivol" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.morohashivol_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.querycodetype" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.querycodetype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.skipmisclass" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.skipmisclass_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.readingtype" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.readingtype_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "kw.kanji.lang" (
    "id" SERIAL NOT NULL,
    "value" TEXT NOT NULL,

    CONSTRAINT "kw.kanji.lang_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "kanji_literal_key" ON "kanji"("literal");

-- CreateIndex
CREATE UNIQUE INDEX "kanji.misc_kanji_id_key" ON "kanji.misc"("kanji_id");

-- CreateIndex
CREATE UNIQUE INDEX "kanji.reading_kanji_id_kwKanjiReadingType_id_value_key" ON "kanji.reading"("kanji_id", "kwKanjiReadingType_id", "value");

-- CreateIndex
CREATE UNIQUE INDEX "kanji.meaning_kanji_id_kwLang_id_value_key" ON "kanji.meaning"("kanji_id", "kwLang_id", "value");

-- CreateIndex
CREATE UNIQUE INDEX "kanji.nanori_kanji_id_value_key" ON "kanji.nanori"("kanji_id", "value");

-- CreateIndex
CREATE UNIQUE INDEX "kanji.variant_kanji_id_kanji_variant_id_key" ON "kanji.variant"("kanji_id", "kanji_variant_id");

-- CreateIndex
CREATE UNIQUE INDEX "kanji.misc.rad_value_key" ON "kanji.misc.rad"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.codepointtype_value_key" ON "kw.kanji.codepointtype"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.radicaltype_value_key" ON "kw.kanji.radicaltype"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.grade_value_key" ON "kw.kanji.grade"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.strokecount_value_key" ON "kw.kanji.strokecount"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.jlpt_value_key" ON "kw.kanji.jlpt"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.dicref_value_key" ON "kw.kanji.dicref"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.morohashivol_value_key" ON "kw.kanji.morohashivol"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.querycodetype_value_key" ON "kw.kanji.querycodetype"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.skipmisclass_value_key" ON "kw.kanji.skipmisclass"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.readingtype_value_key" ON "kw.kanji.readingtype"("value");

-- CreateIndex
CREATE UNIQUE INDEX "kw.kanji.lang_value_key" ON "kw.kanji.lang"("value");

-- AddForeignKey
ALTER TABLE "kanji.codepoint" ADD CONSTRAINT "kanji.codepoint_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.codepoint" ADD CONSTRAINT "kanji.codepoint_kw_codepoint_id_fkey" FOREIGN KEY ("kw_codepoint_id") REFERENCES "kw.kanji.codepointtype"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.misc" ADD CONSTRAINT "kanji.misc_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.misc" ADD CONSTRAINT "kanji.misc_grade_id_fkey" FOREIGN KEY ("grade_id") REFERENCES "kw.kanji.grade"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.misc" ADD CONSTRAINT "kanji.misc_strokeCount_id_fkey" FOREIGN KEY ("strokeCount_id") REFERENCES "kw.kanji.strokecount"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.misc" ADD CONSTRAINT "kanji.misc_jlpt_id_fkey" FOREIGN KEY ("jlpt_id") REFERENCES "kw.kanji.jlpt"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.dicref" ADD CONSTRAINT "kanji.dicref_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.dicref" ADD CONSTRAINT "kanji.dicref_kwDicRefType_id_fkey" FOREIGN KEY ("kwDicRefType_id") REFERENCES "kw.kanji.dicref"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.dicref" ADD CONSTRAINT "kanji.dicref_kwMorohashiVol_id_fkey" FOREIGN KEY ("kwMorohashiVol_id") REFERENCES "kw.kanji.morohashivol"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.querycode" ADD CONSTRAINT "kanji.querycode_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.querycode" ADD CONSTRAINT "kanji.querycode_kwQueryCodeType_id_fkey" FOREIGN KEY ("kwQueryCodeType_id") REFERENCES "kw.kanji.querycodetype"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.querycode" ADD CONSTRAINT "kanji.querycode_kwSkipMisclass_id_fkey" FOREIGN KEY ("kwSkipMisclass_id") REFERENCES "kw.kanji.skipmisclass"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.reading" ADD CONSTRAINT "kanji.reading_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.reading" ADD CONSTRAINT "kanji.reading_kwKanjiReadingType_id_fkey" FOREIGN KEY ("kwKanjiReadingType_id") REFERENCES "kw.kanji.readingtype"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.meaning" ADD CONSTRAINT "kanji.meaning_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.meaning" ADD CONSTRAINT "kanji.meaning_kwLang_id_fkey" FOREIGN KEY ("kwLang_id") REFERENCES "kw.kanji.lang"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.nanori" ADD CONSTRAINT "kanji.nanori_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.variant" ADD CONSTRAINT "kanji.variant_kanji_id_fkey" FOREIGN KEY ("kanji_id") REFERENCES "kanji"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.variant" ADD CONSTRAINT "kanji.variant_kanji_variant_id_fkey" FOREIGN KEY ("kanji_variant_id") REFERENCES "kanji"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "kanji.misc.rad" ADD CONSTRAINT "kanji.misc.rad_kanjiMisc_id_fkey" FOREIGN KEY ("kanjiMisc_id") REFERENCES "kanji.misc"("kanji_id") ON DELETE CASCADE ON UPDATE CASCADE;
