# Nagara Database


## Preparation

### Parse input files

Download the following files and store them in the `input` directory. 

| File                | Link                                                 |
| ------------------- | ---------------------------------------------------- |
| JMdict.gz           | http://ftp.edrdg.org/pub/Nihongo//JMdict.gz          |
| JMdictFurigana.json | https://github.com/Doublevil/JmdictFurigana/releases |
| kanjidic2.xml.gz    | http://nihongo.monash.edu/kanjidic2/kanjidic2.xml.gz |
| kradzip.zip         | http://ftp.edrdg.org/pub/Nihongo/kradzip.zip         |


Unzip the `kradzip.zip` file localy and store the files `kradfile`, `kradfile2` and `radkfilex` in the `input` directory



### Create the postgres database

1. Create a `.env` file in the root directory
2. Set the `DATABASE_URL` in your `.env` file like `postgresql://test:test@localhost:5432/test?schema=foo`


## Scripts

| Script              | Description                                   | 
| ------------------- | --------------------------------------------- |
| `npm run jmdict`    | Creates the `jmdict.json` file in `output`    |
| `npm run kanjidic2` | Creates the `kanjidic2.json` file in `output` |
| `npm run radkfilex` | Creates the `kradfilex.json` file in `output` |
| `npm run kradfilex` | Creates the `radkfilex.json` file in `output` |