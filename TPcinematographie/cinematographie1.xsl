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
                <xsl:apply-templates select="films/film" />
            </body>
        </html>
    </xsl:template>

    <xsl:template match="film">
        <h2>
            <xsl:value-of select="titre" />
        </h2>
        <p><i>
            <xsl:value-of select="nationalite" /> de 
            <xsl:value-of select="duree" />mn sorti en 
            <xsl:value-of select="@annee" />
        </i></p>
        <p><b>Réalisé par : </b><xsl:value-of select="realisateur" /></p>
        
        <p><b>Acteurs :</b></p>
        <ul>
            <xsl:for-each select="acteurs/acteur">
                <li>
                    <xsl:value-of select="//acteurDescription[@id=current()/@ref]/nom" />
                </li>
            </xsl:for-each>
        </ul>
    </xsl:template>

</xsl:stylesheet>
