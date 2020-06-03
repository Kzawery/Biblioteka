<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:template match="/">
        <xsl:text>
create table TypOkladki(
        skrot varchar(2) primary key,
        nazwaTypu varchar(6),
        )


create table Ksiazka(
        id varchar(15) primary key,
        cena float,
        autor varchar(30),
        opis varchar(255),
        ilosc int,
        typo foreign key references TypOkladki(skrot)
        )


create table Klient(
        idKlienta varchar(30) primary key,
        imie varchar(30),
        nazwisko varchar(30),
        email varchar(30),
        )

create table Koszyk (
        id int primary key identity,
        idKlienta varchar(30) references Klient(idKlienta),
        )

create table Produkt (
        id int primary key identity,
        idKsiazki int references Ksiazka(id),
        idKoszyka varchar(30) references Koszyk(id),
        ilosc int
        )

        </xsl:text>
<xsl:apply-templates/>


</xsl:template>

<xsl:template match="ksiegarnia">
    <xsl:apply-templates select="ksiazki"/>
    <xsl:apply-templates select="typyOkladek"/>
    <xsl:apply-templates select="klienci"/>
    <xsl:apply-templates select="koszyki"/>
</xsl:template>

<xsl:template match="ksiazki">
        <xsl:apply-templates select="ksiazka"/>
</xsl:template>

    <xsl:template match="ksiazka">
<xsl:text> insert into Ksiazka values ('</xsl:text>
<xsl:value-of select="@id"/> <xsl:text>, </xsl:text>  
<xsl:value-of select="cena/@jednostkaCeny"/> <xsl:text>', </xsl:text>
<xsl:value-of select="autor"/> <xsl:text>', </xsl:text>
<xsl:value-of select="opis"/> <xsl:text>', </xsl:text>
<xsl:value-of select="ilosc"/> <xsl:text>', </xsl:text>
<xsl:value-of select="@typo"/>
<xsl:text>')
</xsl:text>

</xsl:template>

<xsl:template match="typyOkladki">
    <xsl:apply-templates select="typOkladki"/>
</xsl:template>

<xsl:template match="typOkladki">
<xsl:text> insert into TypOkladki values ('</xsl:text>
<xsl:value-of select="skrot"/> <xsl:text>', '</xsl:text>
<xsl:value-of select="nazwaTypu"/><xsl:text>')
</xsl:text>

    </xsl:template>

    <xsl:template match="klienci">
        <xsl:apply-templates select="klient"/>
    </xsl:template>

    <xsl:template match="klient">
<xsl:text> insert into Klient values (</xsl:text>
<xsl:value-of select="imie"/> <xsl:text>', '</xsl:text>
<xsl:value-of select="nazwisko"/> <xsl:text>', '</xsl:text>
<xsl:value-of select="email"/>
<xsl:text>')
</xsl:text>

    </xsl:template>

    <xsl:template match="koszyki">
      <xsl:apply-templates select="koszyk"/>
    </xsl:template>

    <xsl:template match="koszyk">
        <xsl:text> insert into Koszyk values ('</xsl:text>
<xsl:apply-templates select="@idKlienta"/> <xsl:text>') 
</xsl:text>

    <xsl:for-each select="produkt">
      <xsl:text> insert into Produkt values ('</xsl:text>
<xsl:apply-templates select="@id"/> <xsl:text>', '</xsl:text>
<xsl:apply-templates select="."/> <xsl:text> ')
</xsl:text>
    </xsl:for-each>

    </xsl:template>
    
</xsl:stylesheet>