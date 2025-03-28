    %let pgm=utl-join-us-addresses-with-census-acs-five-yr-block-group-data-most-granular;

    %stop_submission;

    Join US addresses with census acs 5yr block group data most granular census data

      github
      https://tinyurl.com/4dscyfye
      https://github.com/rogerjdeangelis/utl-join-us-addresses-with-census-acs-five-yr-block-group-data-most-granular


        MANUAL OPERATIONS (I could not do this two steps programatically, ms onedrive security issue?)

         ADDRESS DATA BASE (use this address instead of the 141 million (there where address repeated wiver very minor lat log, I averaged them)

          1  download adr_fix132e6.exe 1432 million addresses (1.45gb win10) into d:/adr/exe/adr_fix132e6.exe (all have the same data)
             https://1drv.ms/u/c/bb0f3c4c9b1dc58b/EeJAnwdAgy9Oo1C4IIzf_VIBVcUhQGZRHBZZ2ulv0gICSQ?e=LXtbdk
             https://drive.google.com/file/d/1j3u9g9X4t5GYoz4O62oEs63RVp_qSlhq/view?usp=drive_link
             https://www.dropbox.com/scl/fi/hijvujwjotftaqiu93dgt/adr_fix132e6.exe?rlkey=efa8b49x52tpc25kz1vloc06g&st=f8insd26&dl=0

          2  Unzip the self extracting 7-zip file you downloaded save in d:/adr/csv/adr_fix132e6.csv
             Just click on the exe file (131,789,977 records)

          3  proc datasets code to label all acs5yr variables (except MOE variables)

         CENSUS ACS 5YR ALL VARIABLES (SAS DATASET)

             https://tinyurl.com/yc87r36p
             https://mcdc.missouri.edu/cgi-bin/broker?_PROGRAM=utils.uex2dex.sas&path=/data/acs2020&dset=variables5yr

             or self extracting 7-zip
             https://1drv.ms/u/c/bb0f3c4c9b1dc58b/Ea6i-HzmUa5MhassZDRQII0BX_pprBA5Zf3hDiOz23h9KA?e=rqVvfo
             https://drive.google.com/file/d/1UwVNFONyuI7H1mCqDVuPOYbnpvEkFdxB/view?usp=sharing
             https://www.dropbox.com/scl/fi/yifs4uw9o0405a76e9lgb/acs5yr.exe?rlkey=nfvddmf4cgqae9x4sudwxycnv&st=wygkkhfz&dl=0

        CONTENTS

            1 detail info on 525 acs columns (acs 5yr us block group level)
              (a must have)

            2 extract vt acs data

            3 extract vt address data

            4 join vt address & acs on min geodist and select only geoid(primary key) from address data
              (we only select geoid from the acs data. we will add the 50+ acs vars later)
              (we do this to save run times)

            5 append 50+ acs vars to combined table using geoid

            6 add labels to all acs variables
              (a must have)

            7 related repos

            8 proc datasets program
              https://tinyurl.com/bddx6k6h
              https://github.com/rogerjdeangelis/utl-join-us-addresses-with-census-acs-five-yr-block-group-data-most-granular/blob/main/lblvar.sas


    AS A SIDE NOTE

      If you have a messy list of addresses the github repository below has code to
      standardize the addresses and create the matchcode that
      can be used to match the output here.
      If you set 1 for matching addresses and 0 for non-matching addresses
      you can use predictive analytics like logistic regression
      to profile likely target addresses.

      github
       https://tinyurl.com/yck8yu68
       https://github.com/rogerjdeangelis/utl-given-a-list-of-messy-addresses-geocode-and-reverse-geocode-using-us-address-database

       https://github.com/rogerjdeangelis/utl_US_address-standardization

      also see repos on end


    /*               _     _
     _ __  _ __ ___ | |__ | | ___ _ __ ___
    | `_ \| `__/ _ \| `_ \| |/ _ \ `_ ` _ \
    | |_) | | | (_) | |_) | |  __/ | | | | |
    | .__/|_|  \___/|_.__/|_|\___|_| |_| |_|
    |_|
    */

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*  ALL VERMONT ADDRESSES WITH 50+ ACS 5YR BLOCK GROUP LEVEL Data (most granular)                                         */
    /*                                                                                                                        */
    /*  Middle Observation(167568 ) of table = vtacsvar - Total Obs 58                                                        */
    /*                                                                                                                        */
    /*   -- CHARACTER --                                                                                                      */
    /*  Variable              Typ    Value                      Label                                                         */
    /*                                                                                                                        */
    /*  NUMBEROFVARIABLES      C16   58                         Number of variables                                           */
    /*  ADR                    C64   30 FAIRGROUND RD 05156     ADR                                                           */
    /*  STATE                  C2    VT                         STATE                                                         */
    /*  GEOID                  C40   1500000US500279666002      Geographic ID                                                 */
    /*  YEARS                  C9    2019-2023                  YEARS                                                         */
    /*  PERIOD                 C1    5                          PERIOD                                                        */
    /*  STAB                   C2    VT                         State postal abbreviation                                     */
    /*  COUNTY                 C5    50027                      County                                                        */
    /*  FIPCO                  C5    50027                      County FIPS code                                              */
    /*  TRACT                  C200  9666.00                    TRACT                                                         */
    /*  BG                     C1    2                          Census Block Group                                            */
    /*                                                                                                                        */
    /*   -- NUMERIC --                                                                                                        */
    /*  AVGLAT                 N8        43.30856               Address Latitude                                              */
    /*  AVGLON                 N8       -72.50494               Address Latitude                                              */
    /*  DIF                     N8    1.1078124373              Distance from Address and GEOID                               */
    /*  DATECREATED            N8           23721               DATECREATED                                                   */
    /*  INTPTLAT               N8       43.298605               Latitude GEOID                                                */
    /*  INTPTLON               N8      -72.487706               Longitude GEOID                                               */
    /*  TOTPOP                 N5             415               Total population                                              */
    /*  MEDIANAGE              N5    56.799999952               Median age in years                                           */
    /*  MALES                  N5             200               Males/TotPop                                                  */
    /*  PCTMALES               N4    48.192749023               Males/TotPop                                                  */
    /*  FEMALES                N5             215               Females/TotPop                                                */
    /*  PCTFEMALES             N4    51.807220459               Females/TotPop                                                */
    /*  WHITE1                 N5             360               White1/TotPop                                                 */
    /*  PCTWHITE1              N4    86.746948242               White1/TotPop                                                 */
    /*  TOTHHS                 N5             274               Total households                                              */
    /*  AVGHHINC               N5    40344.890503               Mean household income                                         */
    /*  MEDIANFAMINC           N5               .               Median family income                                          */
    /*  MEDIANNONFAMINC        N5               .               Median nonfamily income                                       */
    /*  LABORFORCE             N5             197               LaborForce/Over16                                             */
    /*  PCTLABORFORCE          N4    49.497467041               LaborForce/Over16                                             */
    /*  CIVLABFORCE            N5             197               CivLabForce/Over16                                            */
    /*  PCTCIVLABFORCE         N4    49.497467041               CivLabForce/Over16                                            */
    /*  EMPLOYEDCLF            N5             197               EmployedCLF/CivLabForce                                       */
    /*  PCTEMPLOYEDCLF         N4             100               EmployedCLF/CivLabForce                                       */
    /*  UNEMPLOYEDCLF          N5               0               UnemployedCLF/CivLabForce                                     */
    /*  PCTUNEMPLOYEDCLF       N4               0               UnemployedCLF/CivLabForce                                     */
    /*  MILITARY               N5               0               Military/Over16                                               */
    /*  PCTMILITARY            N4               0               Military/Over16                                               */
    /*  AVGHHSIZE              N5    1.5099999979               Average household size                                        */
    /*  AVGFAMSIZE             N5     3.136363633               Average family size                                           */
    /*  HHPOP                  N5             415               HHPop/TotPop                                                  */
    /*  NEVERMARRIED           N5             135               NeverMarried/Over15                                           */
    /*  PCTNEVERMARRIED        N4    33.919586182               NeverMarried/Over15                                           */
    /*  MARRIED                N5             160               Married/Over15                                                */
    /*  PCTMARRIED             N4     40.20098877               Married/Over15                                                */
    /*  INCOLLEGE              N5               0               InCollege/EnrolledOver3                                       */
    /*  PCTINCOLLEGE           N4               0               InCollege/EnrolledOver3                                       */
    /*  ASSOCIATES             N5              73               Associates/Over25                                             */
    /*  PCTASSOCIATES          N4    20.916900635               Associates/Over25                                             */
    /*  BACHELORS              N5             100               Bachelors/Over25                                              */
    /*  PCTBACHELORS           N4    28.653289795               Bachelors/Over25                                              */
    /*  BACHELORSORMORE        N5             117               Bachelorsormore/Over25                                        */
    /*  PCTBACHELORSORMORE     N4    33.524353027               Bachelorsormore/Over25                                        */
    /*  VETERAN                N5              27               Veteran/Civilian                                              */
    /*  PCTVETERAN             N4    6.7839164734               Veteran/Civilian                                              */
    /**************************************************************************************************************************/


    SOAPBOX ON

      My understanding verified by perplexity AI?

      Your understanding is largely correct.

      Census Block Groups indeed represent the most granular level
      of useful demographic data available from the U.S. Census Bureau for most purposes. Here are some
      key points to clarify and expand on your statement:

     1. Census Block Groups are the smallest
      geographic unit for which the Census Bureau publishes sample data[2][4]. They typically contain
      between 600 and 3,000 people[2][5].

     2. While Census Blocks are smaller than Block Groups, the
      Census Bureau does not publish detailed demographic data at the block level due to confidentiality
      concerns[3][7]. Blocks are primarily used for defining geographic boundaries[6].

     3. The
      American Community Survey (ACS) provides detailed demographic and socioeconomic data at the Block
      Group level through its 5-year estimates[4][5].

     4. Census Tracts, which contain multiple
      Block Groups, are designed to be relatively homogeneous units with respect to population
      characteristics, economic status, and living conditions[6].

     5. The hierarchical structure of
      Census geography is as follows: Nation > State > County > Census Tract > Block Group > Block[6].


     6. For polygon data (geographic boundaries), Census Blocks may indeed be a better source, as
      they provide the most detailed level of geography[6]. The Summary File 1 (SF1) from the decennial
      census contains this block-level geographic information[9].

     7. The Census Bureau employs
      various disclosure avoidance techniques, including differential privacy, to protect individual
      confidentiality while still providing useful aggregate data[3][7][11].

     In summary, Census
      Block Groups are the smallest geographic unit for which detailed demographic data is publicly
      available, making them crucial for many types of demographic and geographic analyses. While Census
      Blocks provide more precise geographic boundaries, they lack the detailed demographic data
      available at the Block Group level.

     Citations:
     [1] https://kalibrate.com/insights/blog/location-intelligence/the-census-and-data-granularity/
     [2] https://en.wikipedia.org/wiki/Census_block_group
     [3] https://www.census.gov/newsroom/blogs/random-samplings/2023/05/what_to_expect_dhc.html
     [4] https://www.census.gov/content/dam/Census/library/publications/2020/acs/acs_researchers_handbook_2020.pdf
     [5] https://www.geocod.io/guides/what-is-a-census-block-group/
     [6] https://learn.arcgis.com/en/related-concepts/united-states-census-geography.htm
     [7] https://www2.census.gov/library/publications/decennial/2020/census-briefs/c2020br-03.pdf
     [8] https://www.census.gov/programs-surveys/geography/guidance/geo-identifiers.html
     [9] https://www.reddit.com/r/gis/comments/tpvh0k/how_to_convert_census_block_group_data_to_census/
     [10] https://proximityone.com/geo_blockgroups.htm
     [11] https://www.census.gov/programs-surveys/popest/data/special-tab/confidentiality.html
     [12] https://pro.arcgis.com/en/pro-app/latest/help/analysis/business-analyst/data-apportionment-and-layers.htm
     [13] https://www2.census.gov/geo/pdfs/reference/GARM/Ch11GARM.pdf

    SOAPBOX OFF


    /*       _      _        _ _   _        __                     ____ ____  ____                              _
    / |   __| | ___| |_ __ _(_) | (_)_ __  / _| ___    ___  _ __  | ___|___ \| ___|   __ _  ___ ___    ___ ___ | |_   _ _ __ ___  _ __  ___
    | |  / _` |/ _ \ __/ _` | | | | | `_ \| |_ / _ \  / _ \| `_ \ |___ \ __) |___ \  / _` |/ __/ __|  / __/ _ \| | | | | `_ ` _ \| `_ \/ __|
    | | | (_| |  __/ || (_| | | | | | | | |  _| (_) || (_) | | | | ___) / __/ ___) || (_| | (__\__ \ | (_| (_) | | |_| | | | | | | | | \__ \
    |_|  \__,_|\___|\__\__,_|_|_| |_|_| |_|_|  \___/  \___/|_| |_||____/_____|____/  \__,_|\___|___/  \___\___/|_|\__,_|_| |_| |_|_| |_|___/
                         _     _
     _ __ ___  _   _ ___| |_  | |__   __ ___   _____  ___
    | `_ ` _ \| | | / __| __| | `_ \ / _` \ \ / / _ \/ __|
    | | | | | | |_| \__ \ |_  | | | | (_| |\ V /  __/\__ \
    |_| |_| |_|\__,_|___/\__| |_| |_|\__,_| \_/ \___||___/

    */


    /**************************************************************************************************************************/
    /* D:/ACS/SD1/ACS_META  HTTPS://TINYURL.COM/YC87R36P  ACSSD1.ACS_META                                                     */
    /* ===================================================================                                                    */
    /* TYPICAL VALUE                                               UNIVERSE_DESCR  (denominators)               ncy           */
    /*                                                             ---------------------------------------------- ----        */
    /*  -- CHARACTER --                                            Total population                               61          */
    /* Variable             Typ      Value                         Total households                               36          */
    /*                                                             Occupied housing units                         28          */
    /* YEAR                  C4      2020                          Civilian employed population 16 years and over 23          */
    /* SUBJECT_GROUP         C20     Social                        Employed civilians                             23          */
    /* UNIVERSE_DESCR        C100    Household population          Total housing units                            22          */
    /* PERCENT_VARIABLE      C50     pctLivingAlone                Household population                           12          */
    /* VARIABLE_NAME         C50     LivingAlone                   Family households                              11          */
    /* MOE_VARIABLE          C50     LivingAlone_moe               Owner-occupied                                 11          */
    /* SHORT_LABEL           C100    Living alone                  ...                                                        */
    /* DEFINITION            C1000   B09019i005 + B09019i008       Males                                           2          */
    /* VARIABLE_FORMAT       C10     comma9.                       Females                                         2          */
    /* UNIVVAR               C50     HHPop                                                                                    */
    /* WTVAR                 C50     Not Used here but typically TotPop                  Folder structure I used              */
    /* PERCENT_DEFINITION    C1000   100.0*LivingAlone/HHPop                             ========================             */
    /* MOE_DEFINITION        C1000   ACS_processing.calc_moe2(B09019m005, B09019m008)       d:/acs                            */
    /* SUBJECT_TITLE         C100    S2. PERSONS BY HOUSEHOLD TYPE / GROUP QUARTERS         d:/acs/sd1                        */
    /* REFTABLES             C50     B09019                                                 d:/acs/txt                        */
    /*                                                              SUBJECT_GROUP                                             */
    /* _N_                   N8      251                             -------------       libnames                             */
    /*                                                               Demographic  64                                          */
    /*  -- NUMERIC --                                                Economic    160        libname acssd1 "d:/acs/sd1";      */
    /* PROFILE_ID            N8       42                             Housing     139        libname adrsd1 "d:/adr/sd1";      */
    /* INDENT_LEVEL          N8        3                             Social      162                                          */
    /* SUBJECT_ID            N8       35                                                                                      */
    /* VARIABLE_ID           N8      498                                                                                      */
    /**************************************************************************************************************************/

    /*                          _
      __ _  ___ ___    ___ ___ | |_   _ _ __ ___  _ __  ___
     / _` |/ __/ __|  / __/ _ \| | | | | `_ ` _ \| `_ \/ __|
    | (_| | (__\__ \ | (_| (_) | | |_| | | | | | | | | \__ \
     \__,_|\___|___/  \___\___/|_|\__,_|_| |_| |_|_| |_|___/

    */

    /***************************************************************************************************************************************/
    /* IDENTIFIERS                                                                                                                         */
    /* ===========                                                                                                                         */
    /*                                                                                                                                     */
    /* YEARS         Years Covered                                                                                                         */
    /* PERIOD        ACS Period                                                                                                            */
    /* DATECREATED   Date Created                                                                                                          */
    /* SUMLEV        Summary level                                                                                                         */
    /* GEOID         Geographic ID                                                                                                         */
    /* AREANAME      Area Name-Legal/Statistical Area Description (LSAD) Term-Part Indicator                                               */
    /* STATE         State                                                                                                                 */
    /* STAB          State postal abbreviation                                                                                             */
    /* COUNTY        County                                                                                                                */
    /* FIPCO         County FIPS code                                                                                                      */
    /* TRACT         Census Track                                                                                                          */
    /* BG            Census Block Group                                                                                                    */
    /* CBSA          Core-Based (metro/micro) Statistical Area                                                                             */
    /* CBSAYR        CBSA vintage                                                                                                          */
    /* LANDSQMI      Land Area (square miles)                                                                                              */
    /* AREASQMI      Total Area (square miles)                                                                                             */
    /*                                                                                                                                     */
    /* INTPTLAT      Latitude   MATCH WOTH ADDRESS CLOSEST DISTANCE                                                                        */
    /* INTPTLON      Longitude  MATCH WOTH ADDRESS CLOSEST DISTANCE                                                                        */
    /*                                                                                                                                     */
    /* TOTPOP20      2020 Census total population                                                                                          */
    /* ESRIID        Geographic Code Identifier                                                                                            */
    /*                                                                                                                                     */
    /*                                                                                                                                     */
    /* TYPICAL VALUES FOR IDENTIFIERS                                                                                                      */
    /* ==============================                                                                                                      */
    /*                                                                                                                                     */
    /*  -- CHARACTER --                                                                                                                    */
    /* Variable           Typ      Value                      Label                                                                        */
    /*                                                                                                                                     */
    /* YEARS               C9      2019-2023                  YEARS                                                                        */
    /* PERIOD              C1      5                          PERIOD                                                                       */
    /* SUMLEV              C3      150                        Summary level                                                                */
    /* GEOID               C40     1500000US560210019012      Geographic ID                                                                */
    /* AREANAME            C200    Block Group 2              Area Name-Legal/Statistical Area Descrip                                     */
    /* STATE               C2      56                         State                                                                        */
    /* STAB                C2      WY                         State postal abbreviation                                                    */
    /* COUNTY              C5      56021                      County                                                                       */
    /* FIPCO               C5      56021                      County FIPS code                                                             */
    /* TRACT               C200    0019.01                    TRACT                                                                        */
    /* BG                  C1      2                          Census Block Group                                                           */
    /* CBSA                C5      16940                      Core-Based (metro/micro) Statistical Area                                     */
    /* CBSAYR              C4      2023                       CBSA vintage                                                                 */
    /* ESRIID              C51     560210019012               Geographic Code Identifier                                                   */
    /* TOTOBS              C16     457                        TOTOBS                                                                       */
    /*                                                                                                                                     */
    /*                                                                                                                                     */
    /*  -- NUMERIC --                                                                                                                      */
    /* DATECREATED         N8             23721               DATECREATED                                                                  */
    /* LANDSQMI            N8      68.693349708               Land Area (square miles)                                                     */
    /* AREASQMI            N8      68.693349708               Total Area (square miles)                                                    */
    /* INTPTLAT            N8          41.25403               INTPTLAT                                                                     */
    /* INTPTLON            N8       -104.664409               INTPTLON                                                                     */
    /* TOTPOP20            N8              2665               2020 Census total population                                                 */
    /*                                                                                                                                     */
    /*                                                                                                                                     */
    /* NOTE FOR MOST OF THESE COLUMNS THERE IS A SECOND COLUMN WITH A '_MOE' EXTENSION ERROR MARGIN.   Variables  1052                     */
    /* ===============================================================================================================                     */
    /*                                                                                                                                     */
    /* COLUMNS                                                                                                                             */
    /*                                                                                                                                     */
    /*  YEARS                 PCTINDIAN2               PCTPOOR                 PCTFINANCE_INS                 PCTUNMARRIEDGIVINGBIRTH      */
    /*  PERIOD                ASIAN2                   POVRATIOUNDERHALF       PROFESSIONAL                   UNMARRIEDGIVINGBIRTHPERK     */
    /*  DATECREATED           PCTASIAN2                PCTPOVRATIOUNDERHALF    PCTPROFESSIONAL                WOMENGIVINGBIRTH             */
    /*  SUMLEV                HAWNPI2                  POVRATIOV5TOV99         EDUC_HEALTH_SOCSVCS            PCTWOMENGIVINGBIRTH          */
    /*  GEOID                 PCTHAWNPI2               PCTPOVRATIOV5TOV99      PCTEDUC_HEALTH_SOCSVCS         WOMEN15TO19GIVINGBIRTH       */
    /*  AREANAME              OTHER2                   POVRATIO1TO2            RECREATIONETC                  PCTWOMEN15TO19GIVINGBIRT     */
    /*  STATE                 PCTOTHER2                PCTPOVRATIO1TO2         PCTRECREATIONETC               WOMEN20TO34GIVINGBIRTH       */
    /*  STAB                  HISPANICPOP              POVRATIOOVER2           OTHERINDUSTRIES                PCTWOMEN20TO34GIVINGBIRT     */
    /*  COUNTY                PCTHISPANICPOP           PCTPOVRATIOOVER2        PCTOTHERINDUSTRIES             WOMEN35TO50GIVINGBIRTH       */
    /*  FIPCO                 NONHISPPOP               POVUNIVERSEUNDER18      PUBLICADMIN                    PCTWOMEN35TO50GIVINGBIRT     */
    /*  TRACT                 PCTNONHISPPOP            POORUNDER18             PCTPUBLICADMIN                 GIVINGBIRTHPERK              */
    /*  BG                    NONHISPWHITE             PCTPOORUNDER18          PRIVWAGEWORKERS                BIRTHRATE15_19               */
    /*  CBSA                  PCTNONHISPWHITE          POVUNIVERSE18_64        PCTPRIVWAGEWORKERS             BIRTHRATE20_34               */
    /*  CBSAYR                NONHISPBLACK             POOR18TO64              GOVWORKERS                     BIRTHRATE35_50               */
    /*  LANDSQMI              PCTNONHISPBLACK          PCTPOOR18TO64           PCTGOVWORKERS                  GRANDPRNTSLVNGWITHGRNDKI     */
    /*  AREASQMI              NONHISPAMIND             POVUNIVERSEOVER65       SELFEMPWORKERS                 GRANDPRNTSCARING             */
    /*  INTPTLAT              PCTNONHISPAMIND          POOROVER65              PCTSELFEMPWORKERS              PCTGRANDPRNTSCARING          */
    /*  INTPTLON              NONHISPASIAN             PCTPOOROVER65           UNPAIDFAMWORKERS               GRANDPRNTSCARINGLT1          */
    /*  TOTPOP20              PCTNONHISPASIAN          FAMILIES                PCTUNPAIDFAMWORKERS            PCTGRANDPRNTSCARINGLT1       */
    /*  ESRIID                NONHISPHAWNPI            POORFAMILIES            TOTPOPNONINST                  GRANDPRNTSCARING1OR2         */
    /*  TOTPOP                PCTNONHISPHAWNPI         PCTPOORFAMILIES         NONINSTUNDER65                 PCTGRANDPRNTSCARING1OR2      */
    /*  AGE0_4                TOTHHS                   POVUNIVERSEFAMILYPOP    PCTNONINSTUNDER65              GRANDPRNTSCARING3OR4         */
    /*  PCTAGE0_4             HHINC0                   POORINFAMILY            NOTINSUREDUNDER65              PCTGRANDPRNTSCARING3OR4      */
    /*  AGE5_9                PCTHHINC0                PCTPOORINFAMILY         PCTNOTINSUREDUNDER65           GRANDPRNTSCARING5ORMORE      */
    /*  PCTAGE5_9             HHINC10                  POVUNIVERSEUNRELATED    PUBLICINSURANCEUNDER65         PCTGRANDPRNTSCARING5ORMO     */
    /*  AGE10_14              PCTHHINC10               POORUNRELATED           PCTPUBLICINSURANCEUNDER65      OVER3                        */
    /*  PCTAGE10_14           HHINC15                  PCTPOORUNRELATED        PRIVATEINSURANCEONLYUNDER65    ENROLLEDOVER3                */
    /*  AGE15_19              PCTHHINC15               OVER16                  PCTPRIVATEINSURANCEONLYUNDER65 PCTENROLLEDOVER3             */
    /*  PCTAGE15_19           HHINC25                  LABORFORCE              NONINSTUNDER18                 INNURSERY                    */
    /*  AGE20_24              PCTHHINC25               PCTLABORFORCE           PCTNONINSTUNDER18              PCTINNURSERY                 */
    /*  PCTAGE20_24           HHINC35                  CIVLABFORCE             NOTINSUREDUNDER18              INKINDERGARTEN               */
    /*  AGE25_34              PCTHHINC35               PCTCIVLABFORCE          PCTNOTINSUREDUNDER18           PCTINKINDERGARTEN            */
    /*  PCTAGE25_34           HHINC50                  EMPLOYEDCLF             PCTFAMHHS                      INELEMENTARY                 */
    /*  AGE35_44              PCTHHINC50               PCTEMPLOYEDCLF          FAMSWITHKIDS                   PCTINELEMENTARY              */
    /*  PCTAGE35_44           HHINC75                  UNEMPLOYEDCLF           PCTFAMSWITHKIDS                INHIGHSCHOOL                 */
    /*  AGE45_54              PCTHHINC75               PCTUNEMPLOYEDCLF        MARRIEDCOUPLES                 PCTINHIGHSCHOOL              */
    /*  PCTAGE45_54           HHINC100                 MILITARY                PCTMARRIEDCOUPLES              INCOLLEGE                    */
    /*  AGE55_59              PCTHHINC100              PCTMILITARY             COUPLESWITHKIDS                PCTINCOLLEGE                 */
    /*  PCTAGE55_59           HHINC150                 NOTINLF                 PCTCOUPLESWITHKIDS             LESSTHAN9TH                  */
    /*  AGE60_64              PCTHHINC150              PCTNOTINLF              SINGLEMALEFAMILIES             PCTLESSTHAN9TH               */
    /*  PCTAGE60_64           HHINC200                 OVER16FEMALES           PCTSINGLEMALEFAMILIES          SOMEHIGHSCHOOL               */
    /*  AGE65_74              PCTHHINC200              PCTOVER16FEMALES        SINGLEFATHERS                  PCTSOMEHIGHSCHOOL            */
    /*  PCTAGE65_74           NUMHHEARNINGS            LABORFORCEFEMALES       PCTSINGLEFATHERS               HIGHSCHOOL                   */
    /*  AGE75_84              PCTNUMHHEARNINGS         PCTLABORFORCEFEMALES    SINGLEFEMALEFAMILIES           PCTHIGHSCHOOL                */
    /*  PCTAGE75_84           NUMHHSOCSEC              CIVLABFORCEFEMALES      PCTSINGLEFEMALEFAMILIES        SOMECOLLEGE                  */
    /*  OVER85                PCTNUMHHSOCSEC           PCTCIVLABFORCEFEMALES   SINGLEMOTHERS                  PCTSOMECOLLEGE               */
    /*  PCTOVER85             NUMHHRETINC              EMPLOYEDFEMALES         PCTSINGLEMOTHERS               ASSOCIATES                   */
    /*  MEDIANAGE             PCTNUMHHRETINC           PCTEMPLOYEDFEMALES      NONFAMHHS                      PCTASSOCIATES                */
    /*  OVER5                 NUMHHSUPPSECINC          OWNKIDSUNDER6           PCTNONFAMHHS                   BACHELORS                    */
    /*  PCTOVER5              PCTNUMHHSUPPSECINC       OWNKIDSU6ALLPRNTSWK     LIVINGALONE                    PCTBACHELORS                 */
    /*  OVER15                NUMHHPUBASSIST           PCTOWNKIDSU6ALLPRNTSWK  PCTLIVINGALONE                 GRADPROF                     */
    /*  PCTOVER15             PCTNUMHHPUBASSIST        OWNKIDSOVER6            OVER65ALONE                    PCTGRADPROF                  */
    /*  UNDER18               NUMHHFOODSTMP            OWNKIDSO6ALLPRNTSWK     PCTOVER65ALONE                 HIGHSCHOOLORMORE             */
    /*  PCTUNDER18            PCTNUMHHFOODSTMP         PCTOWNKIDSO6ALLPRNTSWK  HHSWITHKIDS                    PCTHIGHSCHOOLORMORE          */
    /*  OVER18                MEDIANHHINC              WORKER16                PCTHHSWITHKIDS                 BACHELORSORMORE              */
    /*  PCTOVER18             AVGHHINC                 COMMUTERS               HHSWITHELDERS                  PCTBACHELORSORMORE           */
    /*  OVER21                AVGHHEARNINGS            PCTCOMMUTERS            PCTHHSWITHELDERS               CIVILIAN                     */
    /*  PCTOVER21             AVGHHSOCSEC              DRIVEALONE              AVGHHSIZE                      VETERAN                      */
    /*  OVER25                AVGHHRETINC              PCTDRIVEALONE           AVGFAMSIZE                     PCTVETERAN                   */
    /*  PCTOVER25             AVGHHSUPPSECINC          CARPOOL                 HHPOP                          DISABLED                     */
    /*  OVER62                AVGHHPUBASSIST           PCTCARPOOL              PCTHHPOP                       PCTDISABLED                  */
    /*  PCTOVER62             FAMHHS                   PUBLICTRANS             FAMHHPOP                       DISABLEDUNDER18              */
    /*  OVER65                FAMHHINC0                PCTPUBLICTRANS          PCTFAMHHPOP                    PCTDISABLEDUNDER18           */
    /*  PCTOVER65             PCTFAMHHINC0             WALKTOWORK              NONFAMHHPOP                    NONINST18_64                 */
    /*  MALES                 FAMHHINC10               PCTWALKTOWORK           PCTNONFAMHHPOP                 PCTNONINST18_64              */
    /*  PCTMALES              PCTFAMHHINC10            OTHERCOMMUTE            NONFAMLIVINGALONE              DISABLED18_64                */
    /*  OVER18MALES           FAMHHINC15               PCTOTHERCOMMUTE         PCTNONFAMLIVINGALONE           PCTDISABLED18_64             */
    /*  PCTOVER18MALES        PCTFAMHHINC15            WORKATHOME              GRPQUARTERS                    NONINSTOVER65                */
    /*  OVER65MALES           FAMHHINC25               PCTWORKATHOME           PCTGRPQUARTERS                 PCTNONINSTOVER65             */
    /*  PCTOVER65MALES        PCTFAMHHINC25            AVGCOMMUTE              HHPOPREL                       DISABLEDELDER                */
    /*  FEMALES               FAMHHINC35               MANPROFOCCS             HOUSEHOLDER                    PCTDISABLEDELDER             */
    /*  PCTFEMALES            PCTFAMHHINC35            PCTMANPROFOCCS          PCTHOUSEHOLDER                 OVER1                        */
    /*  OVER18FEMALES         FAMHHINC50               SERVICEOCCS             SPOUSE                         SAMEHOUSE                    */
    /*  PCTOVER18FEMALES      PCTFAMHHINC50            PCTSERVICEOCCS          PCTSPOUSE                      PCTSAMEHOUSE                 */
    /*  OVER65FEMALES         FAMHHINC75               SALESOFFOCCS            CHILD                          DIFFHOUSE                    */
    /*  PCTOVER65FEMALES      PCTFAMHHINC75            PCTSALESOFFOCCS         PCTCHILD                       PCTDIFFHOUSE                 */
    /*  ONERACE               FAMHHINC100              FARMFISHOCCS            OTHERRELATIVE                  DIFFHOUSESAMECOUNTY          */
    /*  PCTONERACE            PCTFAMHHINC100           PCTFARMFISHOCCS         PCTOTHERRELATIVE               PCTDIFFHOUSESAMECOUNTY       */
    /*  WHITE1                FAMHHINC150              CONSOCCS                NONRELATIVE                    DIFFCOUNTY                   */
    /*  PCTWHITE1             PCTFAMHHINC150           PCTCONSOCCS             PCTNONRELATIVE                 PCTDIFFCOUNTY                */
    /*  BLACK1                FAMHHINC200              TRANSOCCS               UNMARRIEDPARTNER               DIFFCNTYSAMESTATE            */
    /*  PCTBLACK1             PCTFAMHHINC200           PCTTRANSOCCS            PCTUNMARRIEDPARTNER            PCTDIFFCNTYSAMESTATE         */
    /*  INDIAN1               MEDIANFAMINC             AGRICULTURE             UMPARTNERHHSPERK               DIFFSTATE                    */
    /*  PCTINDIAN1            AVGFAMINC                PCTAGRICULTURE          NEVERMARRIED                   PCTDIFFSTATE                 */
    /*  ASIAN1                MEDIANNONFAMINC          CONSTRUCTION            PCTNEVERMARRIED                LIVEDABROAD                  */
    /*  PCTASIAN1             AVGNONFAMINC             PCTCONSTRUCTION         MARRIED                        PCTLIVEDABROAD               */
    /*  HAWNPI1               PCI                      MANUFACTURING           PCTMARRIED                     USNATIVE                     */
    /*  PCTHAWNPI1            FULLTIMEWORKERS          PCTMANUFACTURING        SEPARATED                      PCTUSNATIVE                  */
    /*  OTHER1                FULLTIMEWORKERSMALE      WHOLESALETRADE          PCTSEPARATED                   BORNINUS                     */
    /*  PCTOTHER1             PCTFULLTIMEWORKERSMALE   PCTWHOLESALETRADE       WIDOWED                        PCTBORNINUS                  */
    /*  MULTIRACE             FULLTIMEWORKERSFEMALE    RETAILTRADE             PCTWIDOWED                     BORNINCURRSTATE              */
    /*  PCTMULTIRACE          PCTFULLTIMEWORKERSFEMALE PCTRETAILTRADE          DIVORCED                       PCTBORNINCURRSTATE           */
    /*  WHITE2                MEDIANEARNINGS           TRANSPORTATION          PCTDIVORCED                    BORNINDIFFSTATE              */
    /*  PCTWHITE2             MEDIANEARNINGSMALE       PCTTRANSPORTATION       WOMEN15TO50                    PCTBORNINDIFFSTATE           */
    /*  BLACK2                MEDIANEARNINGSFEMALE     INFORMATION             UNMARRIEDWOMEN15TO50           BORNABROAD                   */
    /*  PCTBLACK2             POVUNIVERSE              PCTINFORMATION          PCTUNMARRIEDWOMEN15TO50        PCTBORNABROAD                */
    /*  INDIAN2               POOR                     FINANCE_INS             UNMARRIEDGIVINGBIRTH           FOREIGNBORN                  */
    /*  ONINSTOVER65          TOTALOWNERUNITS          HVAL150                 PCTNONCITIZEN                  PCTHHFELECTRIC               */
    /*  CTNONINSTOVER65       OWNERVACRATE             PCTHVAL150              BORNOUTSIDEUS                  HHFKEROSENE                  */
    /*  ISABLEDELDER          TOTALRENTALUNITS         HVAL200                 BORNOUTSIDEUSNATIVE            PCTHHFKEROSENE               */
    /*  CTDISABLEDELDER       RENTERVACRATE            PCTHVAL200              PCTBORNOUTSIDEUSNATIVE         HHFCOAL                      */
    /*  VER1                  PERSONSINOWNERUNITS      HVAL300                 NATIVEENTEREDGE2000            PCTHHFCOAL                   */
    /*  AMEHOUSE              PCTPERSONSINOWNERUNITS   PCTHVAL300              PCTNATIVEENTEREDGE2000         HHFWOOD                      */
    /*  CTSAMEHOUSE           PERSONSINRENTERUNITS     HVAL500                 NATIVEENTEREDLT2000            PCTHHFWOOD                   */
    /*  IFFHOUSE              PCTPERSONSINRENTERUNITS  PCTHVAL500              PCTNATIVEENTEREDLT2000         HHFSOLAR                     */
    /*  CTDIFFHOUSE           UNITS1                   HVALOVERMILLION         BORNOUTSIDEUSFB                PCTHHFSOLAR                  */
    /*  IFFHOUSESAMECOUNTY    PCTUNITS1                PCTHVALOVERMILLION      PCTBORNOUTSIDEUSFB             HHFOTHER                     */
    /*  CTDIFFHOUSESAMECOUNTY UNITS1DETACHED           HVALOVER2MILLION        FBENTEREDGE2000                PCTHHFOTHER                  */
    /*  IFFCOUNTY             PCTUNITS1DETACHED        PCTHVALOVER2MILLION     PCTFBENTEREDGE2000             HHFNOFUEL                    */
    /*  CTDIFFCOUNTY          UNITS1ATTACHED           MEDIANHVALUE            FBENTEREDLT2000                PCTHHFNOFUEL                 */
    /*  IFFCNTYSAMESTATE      PCTUNITS1ATTACHED        AVGHVALUE               PCTFBENTEREDLT2000             NOPLUMBING                   */
    /*  CTDIFFCNTYSAMESTATE   UNITS2                   HUSMORT                 FBMINUSSEA                     PCTNOPLUMBING                */
    /*  IFFSTATE              PCTUNITS2                PCTHUSMORT              FBEUROPE                       NOKITCHEN                    */
    /*  CTDIFFSTATE           UNITS3_4                 HUSMORTOVER30PCT        PCTFBEUROPE                    PCTNOKITCHEN                 */
    /*  IVEDABROAD            PCTUNITS3_4              PCTHUSMORTOVER30PCT     FBASIA                         NOPHONE                      */
    /*  CTLIVEDABROAD         UNITS5_9                 MEDIANOWNERCOSTSMORT    PCTFBASIA                      PCTNOPHONE                   */
    /*  SNATIVE               PCTUNITS5_9              HUSNOMORT               FBAFRICA                       PERSONSPERROOMLOW            */
    /*  CTUSNATIVE            UNITS10_19               PCTHUSNOMORT            PCTFBAFRICA                    PCTPERSONSPERROOMLOW         */
    /*  ORNINUS               PCTUNITS10_19            HUSNOMORTOVER30PCT      FBOCEANIA                      PERSONSPERROOMMEDIUM         */
    /*  CTBORNINUS            UNITS20UP                PCTHUSNOMORTOVER30PCT   PCTFBOCEANIA                   PCTPERSONSPERROOMMEDIUM      */
    /*  ORNINCURRSTATE        PCTUNITS20UP             MEDIANOWNERCOSTSNOMORT  FBLATINAMERICA                 PERSONSPERROOMHIGH           */
    /*  CTBORNINCURRSTATE     MOBILEHOMES              CASHRENTER              PCTFBLATINAMERICA              PCTPERSONSPERROOMHIGH        */
    /*  ORNINDIFFSTATE        PCTMOBILEHOMES           PCTCASHRENTER           FBNORTHAMERICA                 HVALUNDER50                  */
    /*  CTBORNINDIFFSTATE     BOATRV                   NOCASHRENTER            PCTFBNORTHAMERICA              PCTHVALUNDER50               */
    /*  ORNABROAD             PCTBOATRV                PCTNOCASHRENTER         OVER5LANG                      HVAL50                       */
    /*  CTBORNABROAD          MOBILEHOMESPERK          MEDIANGROSSRENT         ENGLISHONLY                    PCTHVAL50                    */
    /*  OREIGNBORN            BUILT2010ORLATER         AVGGROSSRENT            PCTENGLISHONLY                 HVAL100                      */
    /*  CTFOREIGNBORN         PCTBUILT2010ORLATER      CASHRENTEROVER30PCT     OTHLANG                        PCTHVAL100                   */
    /*  ATURALIZED            BUILT2000_2009           PCTCASHRENTEROVER30PCT  PCTOTHLANG                                                  */
    /*  CTNATURALIZED         PCTBUILT2000_2009        CASHRENTEROVER750       OTHLANGENGLISHLTD                                           */
    /*  PANISH                BUILT1980_1989           PCTOCCHUS               MOVEDIN1990_1999                                            */
    /*  CTSPANISH             PCTBUILT1980_1989        OWNEROCC                PCTMOVEDIN1990_1999                                         */
    /*  PANISHENGLISHLTD      BUILT1970_1979           PCTOWNEROCC             MOVEDINBEFORE1990                                           */
    /*  CTSPANISHENGLISHLTD   PCTBUILT1970_1979        RENTEROCC               PCTMOVEDINBEFORE1990                                        */
    /*  OCOMPUTER             BUILT1960_1969           PCTRENTEROCC            NOVEHICLES                                                  */
    /*  CTNOCOMPUTER          PCTBUILT1960_1969        AVGOWNERHHSIZE          PCTNOVEHICLES                                               */
    /*  OMPUTER               BUILT1950_1959           AVGRENTERHHSIZE         VEHICLES1                                                   */
    /*  CTCOMPUTER            PCTBUILT1950_1959        VACHUS                  PCTVEHICLES1                                                */
    /*  IALUPINTERNET         BUILT1940_1949           PCTVACHUS               VEHICLES2                                                   */
    /*  CTDIALUPINTERNET      PCTBUILT1940_1949        VACANTFORSALE           PCTVEHICLES2                                                */
    /*  ROADBANDINTERNET      BUILTBEFORE1940          PCTVACANTFORSALE        VEHICLESGE3                                                 */
    /*  CTBROADBANDINTERNET   PCTBUILTBEFORE1940       VACANTFORRENT           PCTVEHICLESGE3                                              */
    /*  OINTERNET             MOVEDIN2010ORLATER       PCTVACANTFORRENT        HHFUTILGAS                                                  */
    /*  CTNOINTERNET          PCTMOVEDIN2010ORLATER    VACANTSEASONAL          PCTHHFUTILGAS                                               */
    /*  OTHUS                 MOVEDIN2000_2009         PCTVACANTSEASONAL       HHFLPGAS                                                    */
    /*  CCHUS                 PCTMOVEDIN2000_2009                                                                                          */
    /***************************************************************************************************************************************/

    /*___              _                  _           _                         _       _
    |___ \    _____  _| |_ _ __ __ _  ___| |_  __   _| |_    __ _  ___ ___   __| | __ _| |_ __ _
      __) |  / _ \ \/ / __| `__/ _` |/ __| __| \ \ / / __|  / _` |/ __/ __| / _` |/ _` | __/ _` |
     / __/  |  __/>  <| |_| | | (_| | (__| |_   \ V /| |_  | (_| | (__\__ \| (_| | (_| | || (_| |
    |_____|  \___/_/\_\\__|_|  \__,_|\___|\__|   \_/  \__|  \__,_|\___|___/ \__,_|\__,_|\__\__,_|
    */


    /*---- WYOMING ACS 5yr Block Group Data ----*/
    data vtprofile;
     set acssd1.acs5yr(where=(stab='VT') keep=
           YEARS
           PERIOD
           DATECREATED
           GEOID
           STAB
           COUNTY
           FIPCO
           TRACT
           BG
           INTPTLAT
           INTPTLON
           TOTPOP
           MEDIANAGE
           MALES
           PCTMALES
           FEMALES
           PCTFEMALES
           WHITE1
           PCTWHITE1
           TOTHHS
           AVGHHINC
           MEDIANFAMINC
           MEDIANNONFAMINC
           PCTPOOR
           POOR18TO64
           PCTPOOR18TO64
           MILITARY
           PCTMILITARY
           LABORFORCE
           PCTLABORFORCE
           CIVLABFORCE
           PCTCIVLABFORCE
           EMPLOYEDCLF
           PCTEMPLOYEDCLF
           UNEMPLOYEDCLF
           PCTUNEMPLOYEDCLF
           LABORFORCEFEMALES
           PCTLABORFORCEFEMALES
           CIVLABFORCEFEMALES
           PCTCIVLABFORCEFEMALES
           EMPLOYEDFEMALES
           LIVINGALONE
           PCTLIVINGALONE
           AVGHHSIZE
           AVGFAMSIZE
           HHPOP
           NEVERMARRIED
           PCTNEVERMARRIED
           MARRIED
           PCTMARRIED
           BIRTHRATE15_19
           BIRTHRATE20_34
           BIRTHRATE35_50
           INCOLLEGE
           PCTINCOLLEGE
           ASSOCIATES
           PCTASSOCIATES
           BACHELORS
           PCTBACHELORS
           BACHELORSORMORE
           PCTBACHELORSORMORE
           VETERAN
           PCTVETERAN
           USNATIVE
           PCTUSNATIVE
           BORNINUS
           PCTBORNINUS
           );
          /*---- 100pct missing ----*/
          drop
             BIRTHRATE15_19
             BIRTHRATE20_34
             BIRTHRATE35_50
             BORNINUS
             CIVLABFORCEFEMALES
             EMPLOYEDFEMALES
             LABORFORCEFEMALES
             LIVINGALONE
             PCTBORNINUS
             PCTCIVLABFORCEFEMALES
             PCTLABORFORCEFEMALES
             PCTLIVINGALONE
             PCTPOOR
             PCTPOOR18TO64
             PCTUSNATIVE
             POOR18TO64
             USNATIVE;
    run;quit;

    /**************************************************************************************************************************/
    /* SAMPLE OUTPUT                                                                                                          */
    /*                                                                                                                        */
    /*    Middle Observation(228 ) of table = wyprofile - Total Obs 457 26MAR2025:16:21:54                                    */
    /*                                                                                                                        */
    /*     -- CHARACTER --                                                                                                    */
    /*    Variable                        Typ    Value                      Label                                             */
    /*                                                                                                                        */
    /*    YEARS                            C9    2019-2023                  YEARS                                             */
    /*    PERIOD                           C1    5                          PERIOD                                            */
    /*    GEOID                            C40   1500000US560210019012      Geographic ID                                     */
    /*    STAB                             C2    WY                         State postal abbreviation                         */
    /*    COUNTY                           C5    56021                      County                                            */
    /*    FIPCO                            C5    56021                      County FIPS code                                  */
    /*    TRACT                            C200  0019.01                    TRACT                                             */
    /*    BG                               C1    2                          Census Block Group                                */
    /*    DATECREATED                      N8    23721                                                                        */
    /*    TOTOBS                           C16   457                                                                          */
    /*                                                                                                                        */
    /*                                                                                                                        */
    /*     -- NUMERIC --                                                                                                      */
    /*    TOTHHS                           N5             847                                                                 */
    /*    INTPTLAT                         N8        41.25403                                                                 */
    /*    INTPTLON                         N8     -104.664409                                                                 */
    /*    TOTPOP                           N5            2333                                                                 */
    /*    MEDIANAGE                        N5    45.699999928                                                                 */
    /*    MALES                            N5            1279                                                                 */
    /*    FEMALES                          N5            1054                                                                 */
    /*    PCTMALES                         N4    54.822113037                                                                 */
    /*    PCTFEMALES                       N4    45.177856445                                                                 */
    /*    WHITE1                           N5            2052                                                                 */
    /*    PCTWHITE1                        N4    87.955383301                                                                 */
    /*    AVGHHINC                         N5    129586.54053                                                                 */
    /*    MEDIANFAMINC                     N5          136932                                                                 */
    /*    MEDIANNONFAMINC                  N5           51667                                                                 */
    /*    LABORFORCE                       N5            1368                                                                 */
    /*    PCTLABORFORCE                    N4     70.33416748                                                                 */
    /*    CIVLABFORCE                      N5            1358                                                                 */
    /*    PCTCIVLABFORCE                   N4    69.820007324                                                                 */
    /*    EMPLOYEDCLF                      N5            1320                                                                 */
    /*    PCTEMPLOYEDCLF                   N4    97.201721191                                                                 */
    /*    UNEMPLOYEDCLF                    N5              38                                                                 */
    /*    PCTUNEMPLOYEDCLF                 N4    2.7982311249                                                                 */
    /*    MILITARY                         N5              10                                                                 */
    /*    PCTMILITARY                      N4    0.5141386986                                                                 */
    /*    AVGHHSIZE                        N5            2.75                                                                 */
    /*    AVGFAMSIZE                       N5    2.9431345314                                                                 */
    /*    HHPOP                            N5            2330                                                                 */
    /*    NEVERMARRIED                     N5             402                                                                 */
    /*    PCTNEVERMARRIED                  N4     19.88130188                                                                 */
    /*    MARRIED                          N5            1483                                                                 */
    /*    PCTMARRIED                       N4    73.343200684                                                                 */
    /*    INCOLLEGE                        N5             160                                                                 */
    /*    PCTINCOLLEGE                     N4    25.764892578                                                                 */
    /*    ASSOCIATES                       N5             281                                                                 */
    /*    PCTASSOCIATES                    N4    18.094009399                                                                 */
    /*    BACHELORS                        N5             393                                                                 */
    /*    PCTBACHELORS                     N4    25.305847168                                                                 */
    /*    BACHELORSORMORE                  N5             586                                                                 */
    /*    PCTBACHELORSORMORE               N4    37.733398438                                                                 */
    /*    VETERAN                          N5             375                                                                 */
    /**************************************************************************************************************************/

    /*____             _                  _           _               _     _
    |___ /    _____  _| |_ _ __ __ _  ___| |_  __   _| |_    __ _  __| | __| |_ __ ___  ___ ___  ___  ___
      |_ \   / _ \ \/ / __| `__/ _` |/ __| __| \ \ / / __|  / _` |/ _` |/ _` | `__/ _ \/ __/ __|/ _ \/ __|
     ___) | |  __/>  <| |_| | | (_| | (__| |_   \ V /| |_  | (_| | (_| | (_| | | |  __/\__ \__ \  __/\__ \
    |____/   \___/_/\_\\__|_|  \__,_|\___|\__|   \_/  \__|  \__,_|\__,_|\__,_|_|  \___||___/___/\___||___/

    */

    libname adrsd1 "d:/adr/sd1";

    proc sql;
      create
         table vtadr as
      select
         adr
        ,state
        ,avglat
        ,avglon
      from
         adrsd1.adr_010adrlonlatfmt
      where
         state="VT"
    ;quit;

    /**************************************************************************************************************************/
    /* Obs    ADR                               STATE     AVGLAT     AVGLON                                                   */
    /*                                                                                                                        */
    /*   1    0V BIG DEER SFH 05046              VT      44.2882    -72.2694                                                  */
    /*   2    1000 4H RD 05829                   VT      44.9344    -72.0998                                                  */
    /*   3    10004 VT RTE 116 05461             VT      44.3377    -73.1149                                                  */
    /*   4    1000 AVALON BCH RD 05735           VT      43.6481    -73.2232                                                  */
    /*   5    1000 BARNES HL RD 05672            VT      44.4291    -72.7298                                                  */
    /*   6    1000 BARTLETT RD 05602             VT      44.2535    -72.6298                                                  */
    /*   7    1000 BEALS HL RD 05492             VT      44.7030    -72.7532                                                  */
    /*   8    1000 BRK RD 05871                  VT      44.6342    -71.9390                                                  */
    /*   9    1000 BROAD ST 05851                VT      44.5335    -72.0026                                                  */
    /*  10    1000 BROOKMAN RD 05261             VT      42.7645    -73.2169                                                  */
    /*  11    1000 BULL RUN RD 05663             VT      44.1024    -72.6774                                                  */
    /*  12    1000 BUMP RD 05759                 VT      43.5134    -72.9495                                                  */
    /*        .....                                                                                                           */
    /**************************************************************************************************************************/

    /*  _       _       _               _               _     _                     ___               _                              _ _     _
    | || |     (_) ___ (_)_ __   __   _| |_    __ _  __| | __| |_ __ ___  ___ ___  ( _ )    _ __ ___ (_)_ __     __ _  ___  ___   __| (_)___| |_
    | || |_    | |/ _ \| | `_ \  \ \ / / __|  / _` |/ _` |/ _` | `__/ _ \/ __/ __| / _ \/\ | `_ ` _ \| | `_ \   / _` |/ _ \/ _ \ / _` | / __| __|
    |__   _|   | | (_) | | | | |  \ V /| |_  | (_| | (_| | (_| | | |  __/\__ \__ \| (_>  < | | | | | | | | | | | (_| |  __/ (_) | (_| | \__ \ |_
       |_|    _/ |\___/|_|_| |_|   \_/  \__|  \__,_|\__,_|\__,_|_|  \___||___/___/ \___/\/ |_| |_| |_|_|_| |_|  \__, |\___|\___/ \__,_|_|___/\__|
             |__/                                                                                               |___/
    */

    /*---- Note I do not add all 50 acs variable here to save time. Will add later -----*/

    proc sql;
      *reset inobs=100;
      create
         table vtjyn as
      select
         l.adr
        ,l.state
        ,l.avglat
        ,l.avglon
        ,geodist(l.avglat,l.avglon,r.intptlat, r.intptlon , 'M') as dif
        ,r.geoid
      from
         vtadr as l left join vtprofile(keep=geoid intptlat intptlon totpop) as r
      on
         1=1
      group
         by adr
      having
                geodist(l.avglat,l.avglon,r.intptlat, r.intptlon , 'M')
          = min(geodist(l.avglat,l.avglon,r.intptlat, r.intptlon , 'M'))
    ;quit;

    /**************************************************************************************************************************/
    /*                                                                      Distance(miles)                                   */
    /*     Obs    ADR                          STATE     AVGLAT     AVGLON   To GEOID             GEOID                       */
    /*                                                                                                                        */
    /*      1    0V BIG DEER SFH 05046         VT      44.2882    -72.2694    3.84967    1500000US500239540002                */
    /*      2    1 A ST 05440                  VT      44.9632    -73.2450    2.26284    1500000US500130201001                */
    /*      3    1 A ST 05829                  VT      44.9631    -72.1226    1.97678    1500000US500199512002                */
    /*      4    1 ABENAKI ACRES 05488         VT      44.9156    -73.1086    0.21065    1500000US500110105002                */
    /*      5    1 ABENAKI WAY 05404           VT      44.4913    -73.1816    0.19681    1500000US500070025021                */
    /*      6    1 ABNAKI AVE 05452            VT      44.4904    -73.1200    0.11766    1500000US500070026014                */
    /*      7    1 ACADEMY ST 05488            VT      44.9172    -73.1244    0.75831    1500000US500110105002                */
    /*      8    1 ACER RDG 05489              VT      44.5061    -72.8930    2.13131    1500000US500070029003                */
    /*      9    1 ACORN CIR 05452             VT      44.4870    -73.0910    0.45515    1500000US500070026022                */
    /*     10    1 ADAMS LNDG RD 05458         VT      44.7318    -73.3364    0.64651    1500000US500130202002                */
    /* ....                                                                                                                   */
    /* 335128    U9 GRANDVIEW DR 05403         VT      44.4504    -73.1746    0.27229    1500000US500070036001                */
    /* 335129    Z1 KENOLIE CAMPGROUND 05345   VT      42.9828    -72.6394    2.31632    1500000US500259678001                */
    /* 335130    Z2 KENOLIE CAMPGROUND 05345   VT      42.9829    -72.6392    2.32683    1500000US500259678001                */
    /* 335131    Z3 KENOLIE CAMPGROUND 05345   VT      42.9827    -72.6391    2.33278    1500000US500259678001                */
    /* 335132    Z4 KENOLIE CAMPGROUND 05345   VT      42.9826    -72.6393    2.32139    1500000US500259678001                */
    /* 335133    Z5 KENOLIE CAMPGROUND 05345   VT      42.9825    -72.6395    2.31222    1500000US500259678001                */
    /* 335134    Z6 KENOLIE CAMPGROUND 05345   VT      42.9824    -72.6397    2.30378    1500000US500259678001                */
    /* 335135    Z7 KENOLIE CAMPGROUND 05345   VT      42.9824    -72.6400    2.29346    1500000US500259678001                */
    /* 335136    Z8 KENOLIE CAMPGROUND 05345   VT      42.9824    -72.6403    2.27792    1500000US500259678001                */
    /* 335137    Z9 KENOLIE CAMPGROUND 05345   VT      42.9823    -72.6401    2.28575    1500000US500259678001                */
    /*                                                                                                                        */
    /**************************************************************************************************************************/

    /*___                                     _   ____   ___                                          _       _     _
    | ___|    __ _ _ __  _ __   ___ _ __   __| | | ___| / _ \   _     __ _  ___ ___  __   ____ _ _ __(_) __ _| |__ | | ___  ___
    |___ \   / _` | `_ \| `_ \ / _ \ `_ \ / _` | |___ \| | | |_| |_  / _` |/ __/ __| \ \ / / _` | `__| |/ _` | `_ \| |/ _ \/ __|
     ___) | | (_| | |_) | |_) |  __/ | | | (_| |  ___) | |_| |_   _|| (_| | (__\__ \  \ V / (_| | |  | | (_| | |_) | |  __/\__ \
    |____/   \__,_| .__/| .__/ \___|_| |_|\__,_| |____/ \___/  |_|   \__,_|\___|___/   \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
                  |_|   |_|
    */
    5 append acs data to combined table
    /*---- get all the acs variables ----*/

    proc sql;
      create
        table vtacsvar as
      select
         distinct
          l.*
         ,r.*
      from
        vtjyn as l left join vtprofile as r
      on
        l.geoid = r.geoid
    ;quit;


    /**************************************************************************************************************************/
    /*  -- CHARACTER --                                                                                                       */
    /* Variable                        Typ    Value                      Label                                                */
    /*                                                                                                                        */
    /* ADR                              C64   30 FAIRGROUND RD 05156     ADR                                                  */
    /* STATE                            C2    VT                         STATE                                                */
    /* GEOID                            C40   1500000US500279666002      Geographic ID                                        */
    /* YEARS                            C9    2019-2023                  YEARS                                                */
    /* PERIOD                           C1    5                          PERIOD                                               */
    /* STAB                             C2    VT                         State postal abbreviat                               */
    /* COUNTY                           C5    50027                      County                                               */
    /* FIPCO                            C5    50027                      County FIPS code                                     */
    /* TRACT                            C200  9666.00                    TRACT                                                */
    /* BG                               C1    2                          Census Block Group                                   */
    /* TOTOBS                           C16   335,137                    TOTOBS                                               */
    /*                                                                                                                        */
    /*                                                                                                                        */
    /*  -- NUMERIC --                                                                                                         */
    /* AVGLAT                           N8        43.30856               AVGLAT                                               */
    /* AVGLON                           N8       -72.50494               AVGLON                                               */
    /* DIF                              N8    1.1078124373               DIF                                                  */
    /* DATECREATED                      N8           23721               DATECREATED                                          */
    /* INTPTLAT                         N8       43.298605               INTPTLAT                                             */
    /* INTPTLON                         N8      -72.487706               INTPTLON                                             */
    /* TOTPOP                           N5             415               TOTPOP                                               */
    /* MEDIANAGE                        N5    56.799999952               MEDIANAGE                                            */
    /* MALES                            N5             200               MALES                                                */
    /* PCTMALES                         N4    48.192749023               PCTMALES                                             */
    /* FEMALES                          N5             215               FEMALES                                              */
    /* PCTFEMALES                       N4    51.807220459               PCTFEMALES                                           */
    /* WHITE1                           N5             360               WHITE1                                               */
    /* PCTWHITE1                        N4    86.746948242               PCTWHITE1                                            */
    /* TOTHHS                           N5             274               TOTHHS                                               */
    /* AVGHHINC                         N5    40344.890503               AVGHHINC                                             */
    /* MEDIANFAMINC                     N5               .               MEDIANFAMINC                                         */
    /* MEDIANNONFAMINC                  N5               .               MEDIANNONFAMINC                                      */
    /* LABORFORCE                       N5             197               LABORFORCE                                           */
    /* PCTLABORFORCE                    N4    49.497467041               PCTLABORFORCE                                        */
    /* CIVLABFORCE                      N5             197               CIVLABFORCE                                          */
    /* PCTCIVLABFORCE                   N4    49.497467041               PCTCIVLABFORCE                                       */
    /* EMPLOYEDCLF                      N5             197               EMPLOYEDCLF                                          */
    /* PCTEMPLOYEDCLF                   N4             100               PCTEMPLOYEDCLF                                       */
    /* UNEMPLOYEDCLF                    N5               0               UNEMPLOYEDCLF                                        */
    /* PCTUNEMPLOYEDCLF                 N4               0               PCTUNEMPLOYEDCLF                                     */
    /* MILITARY                         N5               0               MILITARY                                             */
    /* PCTMILITARY                      N4               0               PCTMILITARY                                          */
    /* AVGHHSIZE                        N5    1.5099999979               AVGHHSIZE                                            */
    /* AVGFAMSIZE                       N5     3.136363633               AVGFAMSIZE                                           */
    /* HHPOP                            N5             415               HHPOP                                                */
    /* NEVERMARRIED                     N5             135               NEVERMARRIED                                         */
    /* PCTNEVERMARRIED                  N4    33.919586182               PCTNEVERMARRIED                                      */
    /* MARRIED                          N5             160               MARRIED                                              */
    /* PCTMARRIED                       N4     40.20098877               PCTMARRIED                                           */
    /* INCOLLEGE                        N5               0               INCOLLEGE                                            */
    /* PCTINCOLLEGE                     N4               0               PCTINCOLLEGE                                         */
    /* ASSOCIATES                       N5              73               ASSOCIATES                                           */
    /* PCTASSOCIATES                    N4    20.916900635               PCTASSOCIATES                                        */
    /* BACHELORS                        N5             100               BACHELORS                                            */
    /* PCTBACHELORS                     N4    28.653289795               PCTBACHELORS                                         */
    /* BACHELORSORMORE                  N5             117               BACHELORSORMORE                                      */
    /* PCTBACHELORSORMORE               N4    33.524353027               PCTBACHELORSORMORE                                   */
    /* VETERAN                          N5              27               VETERAN                                              */
    /* PCTVETERAN                       N4    6.7839164734               PCTVETERAN                                           */
    /**************************************************************************************************************************/

    /*__               _     _   _       _          _       _                _ _                                   _       _     _
     / /_     __ _  __| | __| | | | __ _| |__   ___| |___  | |_ ___     __ _| | |  __ _  ___ ___  __   ____ _ _ __(_) __ _| |__ | | ___  ___
    | `_ \   / _` |/ _` |/ _` | | |/ _` | `_ \ / _ \ / __| | __/ _ \   / _` | | | / _` |/ __/ __| \ \ / / _` | `__| |/ _` | `_ \| |/ _ \/ __|
    | (_) | | (_| | (_| | (_| | | | (_| | |_) |  __/ \__ \ | || (_) | | (_| | | || (_| | (__\__ \  \ V / (_| | |  | | (_| | |_) | |  __/\__ \
     \___/   \__,_|\__,_|\__,_| |_|\__,_|_.__/ \___|_|___/  \__\___/   \__,_|_|_| \__,_|\___|___/   \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/

    */

    data myvars;
     input myacsvar $32.;
    cards4;
    TOTPOP
    MEDIANAGE
    MALES
    PCTMALES
    FEMALES
    PCTFEMALES
    WHITE1
    PCTWHITE1
    TOTHHS
    AVGHHINC
    MEDIANFAMINC
    MEDIANNONFAMINC
    PCTPOOR
    POOR18TO64
    PCTPOOR18TO64
    MILITARY
    PCTMILITARY
    LABORFORCE
    PCTLABORFORCE
    CIVLABFORCE
    PCTCIVLABFORCE
    EMPLOYEDCLF
    PCTEMPLOYEDCLF
    UNEMPLOYEDCLF
    PCTUNEMPLOYEDCLF
    LABORFORCEFEMALES
    PCTLABORFORCEFEMALES
    CIVLABFORCEFEMALES
    PCTCIVLABFORCEFEMALES
    EMPLOYEDFEMALES
    LIVINGALONE
    PCTLIVINGALONE
    AVGHHSIZE
    AVGFAMSIZE
    HHPOP
    NEVERMARRIED
    PCTNEVERMARRIED
    MARRIED
    PCTMARRIED
    BIRTHRATE15_19
    BIRTHRATE20_34
    BIRTHRATE35_50
    INCOLLEGE
    PCTINCOLLEGE
    ASSOCIATES
    PCTASSOCIATES
    BACHELORS
    PCTBACHELORS
    BACHELORSORMORE
    PCTBACHELORSORMORE
    VETERAN
    PCTVETERAN
    USNATIVE
    PCTUSNATIVE
    BORNINUS
    PCTBORNINUS
    ;;;;
    run;quit;

    proc sql;
      create
         table mymeta as
      select
        distinct
         l.myacsvar
        ,coalesce(substr(PERCENT_DEFINITION,7),short_label) as label
        ,cats(l.myacsvar,'="',calculated label,'"') as lblvar
      from
         myvars as l left join acssd1.acs_meta as r
      on
         upcase(strip(r.variable_name)) = strip(l.myacsvar) or
         upcase(strip(r.PERCENT_VARIABLE)) = strip(l.myacsvar)
    ;quit;

     /**********************************************************************************************************************************/
     /* MYACSVAR              LABEL                                LBLVAR                                                              */
     /*                                                                                                                                */
     /* ASSOCIATES            Associates/Over25                    ASSOCIATES="Associates/Over25"                                      */
     /* AVGFAMSIZE            Average family size                  AVGFAMSIZE="Average family size"                                    */
     /* AVGHHINC              Mean household income                AVGHHINC="Mean household income"                                    */
     /* AVGHHSIZE             Average household size               AVGHHSIZE="Average household size"                                  */
     /* BACHELORS             Bachelors/Over25                     BACHELORS="Bachelors/Over25"                                        */
     /* BACHELORSORMORE       Bachelorsormore/Over25               BACHELORSORMORE="Bachelorsormore/Over25"                            */
     /* BIRTHRATE15_19        Per 1,000 women 15 to 19 years old   BIRTHRATE15_19="Per 1,000 women 15 to 19 years old"                 */
     /* BIRTHRATE20_34        Per 1,000 women 20 to 34 years old   BIRTHRATE20_34="Per 1,000 women 20 to 34 years old"                 */
     /* BIRTHRATE35_50        Per 1,000 women 35 to 50 years old   BIRTHRATE35_50="Per 1,000 women 35 to 50 years old"                 */
     /* BORNINUS              BornInUS/USNative                    BORNINUS="BornInUS/USNative"                                        */
     /* CIVLABFORCE           CivLabForce/Over16                   CIVLABFORCE="CivLabForce/Over16"                                    */
     /* CIVLABFORCEFEMALES    CivLabForceFemales/Over16            CIVLABFORCEFEMALES="CivLabForceFemales/Over16"                      */
     /* EMPLOYEDCLF           Civilian employed pop 16 years+      EMPLOYEDCLF="Civilian employed population 16 years and over"        */
     /* EMPLOYEDCLF           EmployedCLF/CivLabForce              EMPLOYEDCLF="EmployedCLF/CivLabForce"                               */
     /* EMPLOYEDFEMALES       EmployedFemales/CivLabForceFemales   EMPLOYEDFEMALES="EmployedFemales/CivLabForceFemales"                */
     /* FEMALES               Females/TotPop                       FEMALES="Females/TotPop"                                            */
     /* HHPOP                 HHPop/HHPop                          HHPOP="HHPop/HHPop"                                                 */
     /* HHPOP                 HHPop/TotPop                         HHPOP="HHPop/TotPop"                                                */
     /* INCOLLEGE             InCollege/EnrolledOver3              INCOLLEGE="InCollege/EnrolledOver3"                                 */
     /* LABORFORCE            LaborForce/Over16                    LABORFORCE="LaborForce/Over16"                                      */
     /* LABORFORCEFEMALES     LaborForceFemales/Over16             LABORFORCEFEMALES="LaborForceFemales/Over16"                        */
     /* LIVINGALONE           LivingAlone/HHPop                    LIVINGALONE="LivingAlone/HHPop"                                     */
     /* MALES                 Males/TotPop                         MALES="Males/TotPop"                                                */
     /* MARRIED               Married/Over15                       MARRIED="Married/Over15"                                            */
     /* MEDIANAGE             Median age in years                  MEDIANAGE="Median age in years"                                     */
     /* MEDIANFAMINC          Median family income                 MEDIANFAMINC="Median family income"                                 */
     /* MEDIANNONFAMINC       Median nonfamily income              MEDIANNONFAMINC="Median nonfamily income"                           */
     /* MILITARY              Military/Over16                      MILITARY="Military/Over16"                                          */
     /* NEVERMARRIED          NeverMarried/Over15                  NEVERMARRIED="NeverMarried/Over15"                                  */
     /* PCTASSOCIATES         Associates/Over25                    PCTASSOCIATES="Associates/Over25"                                   */
     /* PCTBACHELORS          Bachelors/Over25                     PCTBACHELORS="Bachelors/Over25"                                     */
     /* PCTBACHELORSORMORE    Bachelorsormore/Over25               PCTBACHELORSORMORE="Bachelorsormore/Over25"                         */
     /* PCTBORNINUS           BornInUS/USNative                    PCTBORNINUS="BornInUS/USNative"                                     */
     /* PCTCIVLABFORCE        CivLabForce/Over16                   PCTCIVLABFORCE="CivLabForce/Over16"                                 */
     /* PCTCIVLABFORCEFEMALES CivLabForceFemales/Over16            PCTCIVLABFORCEFEMALES="CivLabForceFemales/Over16"                   */
     /* PCTEMPLOYEDCLF        EmployedCLF/CivLabForce              PCTEMPLOYEDCLF="EmployedCLF/CivLabForce"                            */
     /* PCTFEMALES            Females/TotPop                       PCTFEMALES="Females/TotPop"                                         */
     /* PCTINCOLLEGE          InCollege/EnrolledOver3              PCTINCOLLEGE="InCollege/EnrolledOver3"                              */
     /* PCTLABORFORCE         LaborForce/Over16                    PCTLABORFORCE="LaborForce/Over16"                                   */
     /* PCTLABORFORCEFEMALES  LaborForceFemales/Over16             PCTLABORFORCEFEMALES="LaborForceFemales/Over16"                     */
     /* PCTLIVINGALONE        LivingAlone/HHPop                    PCTLIVINGALONE="LivingAlone/HHPop"                                  */
     /* PCTMALES              Males/TotPop                         PCTMALES="Males/TotPop"                                             */
     /* PCTMARRIED            Married/Over15                       PCTMARRIED="Married/Over15"                                         */
     /* PCTMILITARY           Military/Over16                      PCTMILITARY="Military/Over16"                                       */
     /* PCTNEVERMARRIED       NeverMarried/Over15                  PCTNEVERMARRIED="NeverMarried/Over15"                               */
     /* PCTPOOR               Poor/PovUniverse                     PCTPOOR="Poor/PovUniverse"                                          */
     /* PCTPOOR18TO64         Poor18to64/PovUniverse18_64          PCTPOOR18TO64="Poor18to64/PovUniverse18_64"                         */
     /* PCTUNEMPLOYEDCLF      UnemployedCLF/CivLabForce            PCTUNEMPLOYEDCLF="UnemployedCLF/CivLabForce"                        */
     /* PCTUSNATIVE           USNative/TotPop                      PCTUSNATIVE="USNative/TotPop"                                       */
     /* PCTVETERAN            Veteran/Civilian                     PCTVETERAN="Veteran/Civilian"                                       */
     /* PCTWHITE1             White1/TotPop                        PCTWHITE1="White1/TotPop"                                           */
     /* POOR18TO64            Poor18to64/PovUniverse18_64          POOR18TO64="Poor18to64/PovUniverse18_64"                            */
     /* TOTHHS                Total households                     TOTHHS="Total households"                                           */
     /* TOTPOP                Total population                     TOTPOP="Total population"                                           */
     /* UNEMPLOYEDCLF         UnemployedCLF/CivLabForce            UNEMPLOYEDCLF="UnemployedCLF/CivLabForce"                           */
     /* USNATIVE              USNative/TotPop                      USNATIVE="USNative/TotPop"                                          */
     /* VETERAN               Veteran/Civilian                     VETERAN="Veteran/Civilian"                                          */
     /* WHITE1                White1/TotPop                        WHITE1="White1/TotPop"                                              */
     /**********************************************************************************************************************************/

    proc sql;
      select
        lblvar
      into
        :_lbl separated by ' '
      from
        mymeta
    ;quit;

    proc datasets lib=work;
       modify vtacsvar;
       label &_lbl;
    run;
    quit;


    /**************************************************************************************************************************/
    /*  ALL VERMONT ADDRESSES WITH OVER 50 ACS 5YR CARIABLES AT THE MOST GRANULAR BLOCK GROUP LEVEL                           */
    /*                                                                                                                        */
    /*  Middle Observation(167568 ) of table = vtacsvar - Total Obs 58                                                        */
    /*                                                                                                                        */
    /*   -- CHARACTER --                                                                                                      */
    /*  Variable              Typ    Value                      Label                                                         */
    /*                                                                                                                        */
    /*  NUMBEROFVARIABLES      C16   58                         Number of variables                                           */
    /*  ADR                    C64   30 FAIRGROUND RD 05156     ADR                                                           */
    /*  STATE                  C2    VT                         STATE                                                         */
    /*  GEOID                  C40   1500000US500279666002      Geographic ID                                                 */
    /*  YEARS                  C9    2019-2023                  YEARS                                                         */
    /*  PERIOD                 C1    5                          PERIOD                                                        */
    /*  STAB                   C2    VT                         State postal abbreviation                                     */
    /*  COUNTY                 C5    50027                      County                                                        */
    /*  FIPCO                  C5    50027                      County FIPS code                                              */
    /*  TRACT                  C200  9666.00                    TRACT                                                         */
    /*  BG                     C1    2                          Census Block Group                                            */
    /*                                                                                                                        */
    /*   -- NUMERIC --                                                                                                        */
    /*  AVGLAT                 N8        43.30856               Address Latitude                                              */
    /*  AVGLON                 N8       -72.50494               Address Latitude                                              */
    /*  DIF                     N8    1.1078124373              Distance from Address and GEOID                               */
    /*  DATECREATED            N8           23721               DATECREATED                                                   */
    /*  INTPTLAT               N8       43.298605               Latitude GEOID                                                */
    /*  INTPTLON               N8      -72.487706               Longitude GEOID                                               */
    /*  TOTPOP                 N5             415               Total population                                              */
    /*  MEDIANAGE              N5    56.799999952               Median age in years                                           */
    /*  MALES                  N5             200               Males/TotPop                                                  */
    /*  PCTMALES               N4    48.192749023               Males/TotPop                                                  */
    /*  FEMALES                N5             215               Females/TotPop                                                */
    /*  PCTFEMALES             N4    51.807220459               Females/TotPop                                                */
    /*  WHITE1                 N5             360               White1/TotPop                                                 */
    /*  PCTWHITE1              N4    86.746948242               White1/TotPop                                                 */
    /*  TOTHHS                 N5             274               Total households                                              */
    /*  AVGHHINC               N5    40344.890503               Mean household income                                         */
    /*  MEDIANFAMINC           N5               .               Median family income                                          */
    /*  MEDIANNONFAMINC        N5               .               Median nonfamily income                                       */
    /*  LABORFORCE             N5             197               LaborForce/Over16                                             */
    /*  PCTLABORFORCE          N4    49.497467041               LaborForce/Over16                                             */
    /*  CIVLABFORCE            N5             197               CivLabForce/Over16                                            */
    /*  PCTCIVLABFORCE         N4    49.497467041               CivLabForce/Over16                                            */
    /*  EMPLOYEDCLF            N5             197               EmployedCLF/CivLabForce                                       */
    /*  PCTEMPLOYEDCLF         N4             100               EmployedCLF/CivLabForce                                       */
    /*  UNEMPLOYEDCLF          N5               0               UnemployedCLF/CivLabForce                                     */
    /*  PCTUNEMPLOYEDCLF       N4               0               UnemployedCLF/CivLabForce                                     */
    /*  MILITARY               N5               0               Military/Over16                                               */
    /*  PCTMILITARY            N4               0               Military/Over16                                               */
    /*  AVGHHSIZE              N5    1.5099999979               Average household size                                        */
    /*  AVGFAMSIZE             N5     3.136363633               Average family size                                           */
    /*  HHPOP                  N5             415               HHPop/TotPop                                                  */
    /*  NEVERMARRIED           N5             135               NeverMarried/Over15                                           */
    /*  PCTNEVERMARRIED        N4    33.919586182               NeverMarried/Over15                                           */
    /*  MARRIED                N5             160               Married/Over15                                                */
    /*  PCTMARRIED             N4     40.20098877               Married/Over15                                                */
    /*  INCOLLEGE              N5               0               InCollege/EnrolledOver3                                       */
    /*  PCTINCOLLEGE           N4               0               InCollege/EnrolledOver3                                       */
    /*  ASSOCIATES             N5              73               Associates/Over25                                             */
    /*  PCTASSOCIATES          N4    20.916900635               Associates/Over25                                             */
    /*  BACHELORS              N5             100               Bachelors/Over25                                              */
    /*  PCTBACHELORS           N4    28.653289795               Bachelors/Over25                                              */
    /*  BACHELORSORMORE        N5             117               Bachelorsormore/Over25                                        */
    /*  PCTBACHELORSORMORE     N4    33.524353027               Bachelorsormore/Over25                                        */
    /*  VETERAN                N5              27               Veteran/Civilian                                              */
    /*  PCTVETERAN             N4    6.7839164734               Veteran/Civilian                                              */
    /**************************************************************************************************************************/

    /*        _       _           _
     _ __ ___| | __ _| |_ ___  __| |  _ __ ___ _ __   ___  ___
    | `__/ _ \ |/ _` | __/ _ \/ _` | | `__/ _ \ `_ \ / _ \/ __|
    | | |  __/ | (_| | ||  __/ (_| | | | |  __/ |_) | (_) \__ \
    |_|  \___|_|\__,_|\__\___|\__,_| |_|  \___| .__/ \___/|___/
                                              |_|
    */

    https://github.com/rogerjdeangelis/utl-converting-us-gps-decimal-latitude-and-longitude-to-census-zcta-zipcodes-geocode
    https://github.com/rogerjdeangelis/utl-given-a-list-of-messy-addresses-geocode-and-reverse-geocode-using-us-address-database
    https://github.com/rogerjdeangelis/utl_geocode_and_reverse_geocode_netherland_addresses_and_latitudes_longitudes
    https://github.com/rogerjdeangelis/utl_geocode_reverse_geocode

    https://github.com/rogerjdeangelis/utl-dept-of-trans-address-database-to-sas-wps-tables-for-geocoding-and-reverse-geocoding
    https://github.com/rogerjdeangelis/utl-free-unlimited-geocoding-reverse-geocoding-wps-aprox-I41-million-addresses-with-gps
    https://github.com/rogerjdeangelis/utl-given-a-list-of-messy-addresses-geocode-and-reverse-geocode-using-us-address-database
    https://github.com/rogerjdeangelis/utl-openaddress-database-to-sas-wps-tables-for-geocoding-and-reverse-geocoding
    https://github.com/rogerjdeangelis/utl-standardize-address-suffix-using-usps-abreviations
    https://github.com/rogerjdeangelis/utl-use-geo-fencing-to-find-all-addresses-in-a-latitude-longitude-quadrangle-reverse-geocoding
    https://github.com/rogerjdeangelis/utl_geocode_and_reverse_geocode_netherland_addresses_and_latitudes_longitudes

    /*___                               _       _                 _
     ( _ )   _ __  _ __ ___   ___    __| | __ _| |_ __ _ ___  ___| |_ ___
     / _ \  | `_ \| `__/ _ \ / __|  / _` |/ _` | __/ _` / __|/ _ \ __/ __|
    | (_) | | |_) | | | (_) | (__  | (_| | (_| | || (_| \__ \  __/ |_\__ \
     \___/  | .__/|_|  \___/ \___|  \__,_|\__,_|\__\__,_|___/\___|\__|___/
            |_|
    */

    /*---- create small 30 ob test of the acssd1.acs5yr census data ----*/
    data tstacs5yr;
      set acssd1.acs5yr(firstobs=30 obs=30);
    run;quit;

    data namlbl;
      length lblvar $200.;
      set acssd1.acs_meta;
      /*---- fix potential quotes within quotes ----*/
      short_label=compress(short_label,"'");
      short_label=compress(short_label,'"');
      lblvar = cats(variable_name,'="',short_label,'"');
      output;
      if not missing(percent_variable) then do;
         lblvar = cats(percent_variable,'="',short_label,'"');
         output;
      end;
      keep lblvar;
    run;quit;

    proc sort data=namlbl out=namlblunq nodupkey;
    by lblvar;
    run;quit;


    %let _libname=work;
    %let _acs5yr=tstacs5yr;

    data namlbl;
      file "%sysfunc(pathname(work))/lblvar.sas";
      set namlblunq end=dne;
      if index(lblvar,"_MOE")=0;
      if _n_=1 then do;
         put "proc datasets lib=&_libname; modify &_acs5yr; label ";
      end;
      else do;
         if dne then Put ";run;quit;";
      end;
    run;quit;

    %inc "%sysfunc(pathname(work))/lblvar.sas";

    ods trace on;
    ods output position=pos;
    proc contents data=tstacs5yr position;
    run;quit;
    ods trace off ;

    proc print data=pos(where=(index(variable,'_MOE')=0));
    run;quit;

    /**************************************************************************************************************************/
    /*                                                                                                                        */
    /*      MEMBER     NUM  VARIABLE     TYPE  LEN     POS    FORMAT       INFORMAT LABEL                                     */
    /*                                                                                                                        */
    /*  WORK.TSTACS5YR   1  YEARS        Char    9    4906                                                                    */
    /*  WORK.TSTACS5YR   2  PERIOD       Char    1    4915                                                                    */
    /*  WORK.TSTACS5YR   3  DATECREATED  Num     8       0    DATE.                                                           */
    /*  WORK.TSTACS5YR   4  SUMLEV       Char    3    4916    $CHAR3.      $CHAR3.  Summary level                             */
    /*  WORK.TSTACS5YR   5  GEOID        Char   40    4919    $CHAR40.     $CHAR40. Geographic ID                             */
    /*  WORK.TSTACS5YR   7  STATE        Char    2    5159    $CHAR2.      $CHAR2.  State                                     */
    /*  WORK.TSTACS5YR   8  STAB         Char    2    5161    $CHAR2.      $CHAR2.  State postal abbreviation                 */
    /*  WORK.TSTACS5YR   9  COUNTY       Char    5    5163    $COUNTY.              County                                    */
    /*  WORK.TSTACS5YR  10  FIPCO        Char    5    5168    $CHAR5.               County FIPS code                          */
    /*  WORK.TSTACS5YR  11  TRACT        Char  200    5173                                                                    */
    /*  WORK.TSTACS5YR  12  BG           Char    1    5373    $CHAR1.      $CHAR1.  Census Block Group                        */
    /*  WORK.TSTACS5YR  13  CBSA         Char    5    5374    $CHAR5.               Core-Based (metro/micro) Statistical Area */
    /*  WORK.TSTACS5YR  14  CBSAYR       Char    4    5379    $CHAR4.               CBSA vintage                              */
    /*  WORK.TSTACS5YR  15  LANDSQMI     Num     8       8    9.2                   Land Area (square miles)                  */
    /*  WORK.TSTACS5YR  16  AREASQMI     Num     8      16    9.2                   Total Area (square miles)                 */
    /*  WORK.TSTACS5YR  17  INTPTLAT     Num     8      24    10.6                                                            */
    /*  WORK.TSTACS5YR  18  INTPTLON     Num     8      32    11.6                                                            */
    /*  WORK.TSTACS5YR  19  TOTPOP20     Num     8      40                          2020 Census total population              */
    /*  WORK.TSTACS5YR  20  ESRIID       Char   51    5383                          Geographic Code Identifier                */
    /*  WORK.TSTACS5YR  21  TOTPOP       Num     5    1256    COMMA12.              Total population                          */
    /*  WORK.TSTACS5YR  22  AGE0_4       Num     5    1261    COMMA12.                                                        */
    /*  WORK.TSTACS5YR  23  PCTAGE0_4    Num     4      48    6.2                   Under 5 years                             */
    /*  WORK.TSTACS5YR  24  AGE5_9       Num     5    1266    COMMA12.              5 to 9 years                              */
    /*  WORK.TSTACS5YR  25  PCTAGE5_9    Num     4      52    6.2                   5 to 9 years                              */
    /*  WORK.TSTACS5YR  26  AGE10_14     Num     5    1271    COMMA12.              10 to 14 years                            */
    /*  WORK.TSTACS5YR  27  PCTAGE10_14  Num     4      56    6.2                   10 to 14 years                            */
    /*  WORK.TSTACS5YR  28  AGE15_19     Num     5    1276    COMMA12.              15 to 19 years                            */
    /*  WORK.TSTACS5YR  29  PCTAGE15_19  Num     4      60    6.2                   15 to 19 years                            */
    /*  WORK.TSTACS5YR  30  AGE20_24     Num     5    1281    COMMA12.              20 to 24 years                            */
    /*  WORK.TSTACS5YR  31  PCTAGE20_24  Num     4      64    6.2                   20 to 24 years                            */
    /*  WORK.TSTACS5YR  32  AGE25_34     Num     5    1286    COMMA12.              25 to 34 years                            */
    /*  WORK.TSTACS5YR  33  PCTAGE25_34  Num     4      68    6.2                   25 to 34 years                            */
    /*  WORK.TSTACS5YR  34  AGE35_44     Num     5    1291    COMMA12.              35 to 44 years                            */
    /*  ....                                                                                                                  */
    /*                                                                                                                        */
    /* file "%sysfunc(pathname(work))/lblvar.sas";                                                                            */
    /*                                                                                                                        */
    /* proc datasets lib=acssd1; modify tstacs5yr; label                                                                      */
    /* Age10_14="10 to 14 years"                                                                                              */
    /* Age15_19="15 to 19 years"                                                                                              */
    /* Age20_24="20 to 24 years"                                                                                              */
    /* Age25_34="25 to 34 years"                                                                                              */
    /* Age35_44="35 to 44 years"                                                                                              */
    /* Age45_54="45 to 54 years"                                                                                              */
    /* Age55_59="55 to 59 years"                                                                                              */
    /* Age5_9="5 to 9 years"                                                                                                  */
    /* Age60_64="60 to 64 years"                                                                                              */
    /* Age65_74="65 to 74 years"                                                                                              */
    /* Age75_84="75 to 84 years"                                                                                              */
    /* Agriculture="Agriculture, forestry, fishing and hunting, and mining"                                                   */
    /* Asian1="Asian"                                                                                                         */
    /* Asian2="Asian (alone or in combination)"                                                                               */
    /* Associates="Associates degree"                                                                                         */
    /* ...                                                                                                                    */
    /* ctWhite2="White (alone or in combination)"                                                                             */
    /* pctWholesaleTrade="Wholesale trade"                                                                                    */
    /* pctWidowed="Widowed"                                                                                                   */
    /* pctWomen15to19="Women 15 to 19 years of age"                                                                           */
    /* pctWomen20to34="Women 20 to 34 years of age"                                                                           */
    /* pctWomen35to50="Women 35 to 50 years of age"                                                                           */
    /* pctWomenGivingBirth="Women 15 to 50 years old who had a birth in the past 12 months"                                   */
    /* pctWorkAtHome="Worked at home"                                                                                         */
    /* ;run;quit;                                                                                                             */
    /**************************************************************************************************************************/


    /*              _
      ___ _ __   __| |
     / _ \ `_ \ / _` |
    |  __/ | | | (_| |
     \___|_| |_|\__,_|

    */

