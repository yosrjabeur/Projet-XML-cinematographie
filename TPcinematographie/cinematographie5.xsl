<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>

    <xsl:template match="/">
        <html>
            <head>
                <title>Mon Film</title>
                <script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
                <script src="scroll.js"></script>
                <link rel="stylesheet" type="text/css" href="scroll.css" />
            </head>
            <body>
                <div id="main">
                    <xsl:apply-templates select="films/film" mode="tdm" />
                </div>
                <script>
                    $("#main").onepage_scroll({
                        sectionContainer: "section",
                        easing: "ease",
                        animationTime: 1000,
                        pagination: true,
                        updateURL: false,
                        beforeMove: function(index) {},
                        afterMove: function(index) {},
                        loop: false,
                        keyboard: true,
                        responsiveFallback: false
                    });
                </script>
            </body>
        </html>
    </xsl:template>
    
    <!-- films -->
    <xsl:template match="film" mode="tdm">
        <section>
            <h2><xsl:value-of select="titre"/></h2>
            <img>
                <xsl:attribute name="src"><xsl:value-of select="image/@ref" /></xsl:attribute>
                <xsl:attribute name="alt"><xsl:value-of select="titre" /></xsl:attribute>
                <xsl:attribute name="width">200</xsl:attribute> 
                <xsl:attribute name="height">auto</xsl:attribute> 
            </img>
            
            <p><strong>Réalisateur:</strong> <xsl:value-of select="realisateur"/></p>
            <p><strong>Année:</strong> <xsl:value-of select="@annee"/></p>
            <p><strong>Description:</strong> <xsl:value-of select="scenario/ev"/></p>
            <p><strong>Durée:</strong> <xsl:value-of select="duree"/> minutes</p>
            <p><strong>Genres:</strong>
                <xsl:for-each select="genres/genre">
                    <xsl:value-of select="."/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </p>
            <p><strong>Acteurs:</strong>
                <xsl:for-each select="acteurs/acteur">
                    <xsl:value-of select="//acteurDescription[@id=current()/@ref]/nom"/>
                    <xsl:if test="position() != last()">, </xsl:if>
                </xsl:for-each>
            </p>
        </section>
    </xsl:template>

    <!-- acteurs -->
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

    <!-- détails film -->
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
