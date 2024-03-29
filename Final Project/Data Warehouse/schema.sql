-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE public."SoftCardDimDate"
(
    dateid integer NOT NULL,
    month smallint NOT NULL,
    monthname "char",
    year integer NOT NULL,
    week integer NOT NULL,
    day smallint NOT NULL,
    dayname "char",
    PRIMARY KEY (dateid)
);

CREATE TABLE public."SoftCardDimCategory"
(
    "CategoryID" integer NOT NULL,
    "CategoryName" "char" NOT NULL,
    PRIMARY KEY ("CategoryID")
);

CREATE TABLE public."softcartDimItem"
(
    "ItemID" integer NOT NULL,
    "ItemName" "char" NOT NULL,
    "ItemDescription" "char",
    "CategoryID" integer NOT NULL,
    "Price" numeric NOT NULL,
    PRIMARY KEY ("ItemID")
);

CREATE TABLE public."softcartDimCountry"
(
    "CountryID" integer NOT NULL,
    "CountryName" "char" NOT NULL,
    PRIMARY KEY ("CountryID")
);

CREATE TABLE public."softcartFactSales"
(
    "OrderID" integer NOT NULL,
    "Month" smallint NOT NULL,
    year integer NOT NULL,
    week integer NOT NULL,
    day smallint NOT NULL,
    "CategoryID" integer NOT NULL,
    "ItemID" integer NOT NULL,
    "Price" integer NOT NULL,
    "CountryID" integer NOT NULL,
    "DateID" integer NOT NULL,
    PRIMARY KEY ("OrderID")
);

ALTER TABLE public."SoftCardDimCategory"
    ADD FOREIGN KEY ("CategoryID")
    REFERENCES public."softcartDimItem" ("CategoryID")
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY ("Month")
    REFERENCES public."SoftCardDimDate" (month)
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY (year)
    REFERENCES public."SoftCardDimDate" (year)
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY (week)
    REFERENCES public."SoftCardDimDate" (week)
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY (day)
    REFERENCES public."SoftCardDimDate" (day)
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY ("CategoryID")
    REFERENCES public."SoftCardDimCategory" ("CategoryID")
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY ("ItemID")
    REFERENCES public."softcartDimItem" ("ItemID")
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY ("Price")
    REFERENCES public."softcartDimItem" ("Price")
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY ("CountryID")
    REFERENCES public."softcartDimCountry" ("CountryID")
    NOT VALID;


ALTER TABLE public."softcartFactSales"
    ADD FOREIGN KEY ("DateID")
    REFERENCES public."SoftCardDimDate" (dateid)
    NOT VALID;

END;