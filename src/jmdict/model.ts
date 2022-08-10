// Documentation
// https://www.edrdg.org/jmdict/jmdict_dtd_h.html

interface JMDict {
    entry: Entr[];
}

interface Entr {
    ent_seq: string;
    k_ele?: Kanji;
    r_ele: Rdng;
    sense: Sens;
}

interface Kanji {
    keb: string;
    ke_inf?: string | string[];
    ke_pri?: string | string[];
}

interface Rdng {
    reb: string;
    re_nokanji?: string;
    re_rest?: string | string[];
    re_inf?: string | string[];
    re_pri?: string | string[];
}

interface Sens {
    stagk?: string | string[];
    stagr?: string | string[];
    pos?: string | string[];
    field?: string | string[];
    misc?: string | string[];
    lsource?: LSrc | LSrc[];
    dial?: string | string[];
    gloss?: string | GlossWithType | GlossNotEng | Array<string | GlossWithType | GlossNotEng>;
    s_inf?: string;
}

interface LSrc {
    value: string;
    lang: string;
    ls_type?: string;
    ls_wasei?: string;
}

interface GlossNotEng {
    value: string;
    lang: string;
}

interface GlossWithType {
    value: string;
    g_type: string;
}