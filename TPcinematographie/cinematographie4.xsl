<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="iso-8859-1" indent="yes"/>
    
    <xsl:template match="/">
        <html>
            <head>
                <title>cinématographie</title>
                <link rel="stylesheet" type="text/css" href="film4.css" />
            </head>
            <body>
                <h1>Cinématographie</h1>
                
                <h2>Table des matières des films</h2>
                <ul>
                    <xsl:apply-templates select="films/film" mode="tdm" />
                </ul>

                <h2>Table des matières des acteurs</h2>
                <ul>
                    <xsl:apply-templates select="//acteurDescription" mode="acteurTDM" />
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
            [<xsl:for-each select="genres/genre">
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>]
        </li>
    </xsl:template>

    <xsl:template match="acteurDescription" mode="acteurTDM">
        <li>
            <xsl:value-of select="nom"/> 
            (<xsl:value-of select="dateNaissance"/>)
            - <xsl:value-of select="count(//acteurs/acteur[@ref=current()/@id])" /> films :
            <xsl:for-each select="//acteurs/acteur[@ref=current()/@id]">
                <a>
                    <xsl:attribute name="href">#<xsl:value-of select="../../titre"/></xsl:attribute>
                    <xsl:value-of select="../../@annee"/>
                </a>
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
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
        <img>
            <xsl:attribute name="src"><xsl:value-of select="image/@ref" /></xsl:attribute>
            <xsl:attribute name="alt"><xsl:value-of select="titre" /></xsl:attribute>
        </img>

        <p><b>Genres :</b> 
            <xsl:for-each select="genres/genre">
                <xsl:value-of select="."/>
                <xsl:if test="position() != last()">, </xsl:if>
            </xsl:for-each>
        </p>

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

        <p><b>Synopsis :</b></p>
        <xsl:apply-templates select="scenario/ev" />

        <p><b>Exploité dans les pays suivants :</b></p>
        <ul>
            <xsl:for-each select="exploitation/listepays/pays">
                <li><xsl:value-of select="." /></li>
            </xsl:for-each>
        </ul>

        <hr/>
    </xsl:template>
    
    <xsl:template match="scenario/ev">
        <p><i>
            <xsl:apply-templates select="node()" />
        </i></p>
    </xsl:template>

    <xsl:template match="scenario/ev/personnage">
        <b><xsl:value-of select="." /></b>
    </xsl:template>
    
</xsl:stylesheet>
