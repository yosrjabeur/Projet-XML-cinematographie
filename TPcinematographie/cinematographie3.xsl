<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>cinématographie</title>
                <link rel="stylesheet" type="text/css" href="film.css" />
            </head>
            <body>
                <h1>Cinématographie</h1>
                
                <h2>Table des matières des films</h2>
                <ul>
                    <xsl:apply-templates select="films/film" mode="tdm" />
                </ul>

                <!-- films -->
                <xsl:apply-templates select="films/film" mode="complet">
                    <xsl:sort select="@annee" order="ascending" data-type="text" />
                </xsl:apply-templates>

            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="film" mode="tdm">
        <li>
            <a>
                <xsl:attribute name="href">#<xsl:value-of select="titre" /></xsl:attribute>
                <xsl:value-of select="titre" />
            </a>
            (<xsl:value-of select="count(acteurs/acteur)" /> acteurs)
        </li>
    </xsl:template>

    <xsl:template match="film" mode="complet">
        <h2>
            <a>
                <xsl:attribute name="name"><xsl:value-of select="titre" /></xsl:attribute>
                <xsl:value-of select="titre" />
            </a>
            (<xsl:value-of select="@annee" />)
        </h2>
        <p><i>
            <xsl:value-of select="nationalite" />, 
            <xsl:value-of select="duree" /> minutes, 
            sorti le <xsl:value-of select="exploitation/date_sortie" />
        </i></p>
        <p><b>Réalisé par :</b> <xsl:value-of select="realisateur" /></p>
        
        <p><b>Acteurs :</b></p>
        <ul>
            <xsl:for-each select="acteurs/acteur">
                <li>
                    <xsl:value-of select="//acteurDescription[@id=current()/@ref]/nom" />
                    (<xsl:value-of select="//acteurDescription[@id=current()/@ref]/dateNaissance" />, 
                    <xsl:value-of select="//acteurDescription[@id=current()/@ref]/lieuNaissance" />)
                </li>
            </xsl:for-each>
        </ul>
        <p><b>Synopsis :</b> <xsl:value-of select="scenario/ev" /></p>

        <p><b>Exploité dans les pays suivants :</b></p>
        <ul>
            <xsl:for-each select="exploitation/listepays/pays">
                <li><xsl:value-of select="." /></li>
            </xsl:for-each>
        </ul>

        <hr/>
    </xsl:template>

</xsl:stylesheet>
