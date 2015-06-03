<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet exclude-result-prefixes="#all" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    version="2.0">
    
    <xsl:template match="/">
<xsl:result-document href="spreadsheet.csv">"Repository","Title","Call No.","Language(s)","Origin","Date","CompuDate","Place","Subject","Genre","Front Cover","Navigation","Data","Ebook","Page Turning","Record","Video","Summary"<xsl:for-each select="collection(iri-to-uri('../../../Documents/openn.library.upenn.edu/Data/?select=*.xml;recurse=yes'))">
            <xsl:variable name="institution" select="//tei:institution"/>
            <xsl:variable name="repository" select="//tei:repository"/>
            <xsl:variable name="title" select="//tei:msContents/tei:msItem[1]/tei:title"/>
            <xsl:variable name="quote">"</xsl:variable>
            <xsl:variable name="callNo" select="concat(//tei:msIdentifier/tei:institution,' ',//tei:msIdentifier/tei:idno[@type='call-number'])"/>
            <xsl:variable name="lang" select="//tei:textLang"/>
            <xsl:variable name="origin" select="//tei:origin/tei:p"/>
            <xsl:variable name="date" select="//tei:origDate"/>
            <xsl:variable name="summary" select="//tei:summary"/>
            <xsl:variable name="compuDate">
                <xsl:choose>
                    <xsl:when
                        test="contains($date,'between')">
                        <xsl:value-of select="substring($date,9,4)"/>-<xsl:value-of select="substring($date,18,4)"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,'--')">
                        <xsl:value-of select="tokenize($date,'--') [position() = 1]"/>00-<xsl:value-of select="tokenize($date,'--') [position() = 1]"/>99</xsl:when>
                    <xsl:when
                        test="contains($date,'-')">
                        <xsl:value-of select="$date"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,'approximately')">
                        <xsl:value-of select="substring($date,15,4)"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,',')">
                        <xsl:value-of select="translate($date,',','-')"/>
                    </xsl:when>
                    <xsl:when
                        test="contains($date,'A.H.')">
                        <xsl:variable name="ah-token" select="tokenize($date,' ') [position() = 2]"/>
                        <xsl:if test="string-length($ah-token) = 3"><xsl:value-of select="substring(//tei:origDate,11,4)"/></xsl:if>
                        <xsl:if test="string-length($ah-token) = 4"><xsl:value-of select="substring(//tei:origDate,12,4)"/></xsl:if>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$date"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:variable>
            <xsl:variable name="place" select="//tei:origin/tei:origPlace"></xsl:variable>
            <xsl:variable name="subjects"><xsl:for-each select="//tei:keywords[@n='subjects']/tei:term"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
            <xsl:variable name="genres"><xsl:for-each select="//tei:keywords[@n='form/genre']/tei:term"><xsl:value-of select="."/>;</xsl:for-each></xsl:variable>
            <xsl:variable name="ljsNo" select="tokenize(translate(document-uri(.),'_TEI.xml',''),'/') [position() = last()]"/>
            <xsl:variable name="path">http://openn.library.upenn.edu/Data/LJSchoenbergManuscripts/</xsl:variable>
            <xsl:variable name="cover" select="//tei:surface[1]/tei:graphic[contains(@url,'web')]/@url"/>
            <xsl:variable name="opennNav" select="concat($path,'html/','l',$ljsNo,'.html')"/>
            <xsl:variable name="opennData" select="concat($path,'l',$ljsNo,'/data/')"/>
            <xsl:variable name="ebook" select="concat('http://dorpdev.library.upenn.edu/ebooks/l',$ljsNo,'.epub')"/>
            <xsl:variable name="pageTurn" select="concat('http://dorpdev.library.upenn.edu/BookReaders/l',$ljsNo,'/index.html#page/1/mode/2up')"/>
            <xsl:variable name="record" select="//tei:altIdentifier[@type='resource']/tei:idno"/>
            <xsl:variable name="video"></xsl:variable>
    "<xsl:value-of select="concat($institution,' ',$repository)"></xsl:value-of>","<xsl:value-of select="translate($title,$quote,concat($quote,$quote))"/>","<xsl:value-of select="$callNo"/>","<xsl:if test="not($lang)">None noted</xsl:if><xsl:value-of select="$lang"/>","<xsl:if test="not($origin)">None noted</xsl:if><xsl:value-of select="$origin"/>","<xsl:if test="not($date)">None noted</xsl:if><xsl:value-of select="$date"/>","<xsl:if test="not($compuDate)"></xsl:if><xsl:value-of select="normalize-space(translate($compuDate,'ca.?afterirbo',''))"/>","<xsl:if test="not($place)">None noted</xsl:if><xsl:value-of select="$place"/>","<xsl:if test="not($subjects)">None noted</xsl:if><xsl:value-of select="$subjects"/>","<xsl:if test="not($genres)">None noted</xsl:if><xsl:value-of select="$genres"/>","<xsl:value-of select="concat($path,'l',$ljsNo,'/','data','/',$cover)"></xsl:value-of>","<xsl:value-of select="$opennNav"/>","<xsl:value-of select="$opennData"/>","<xsl:value-of select="$ebook"/>","<xsl:value-of select="$pageTurn"/>","<xsl:value-of select="$record"/>","","<xsl:value-of select="$summary"></xsl:value-of>"</xsl:for-each>
    </xsl:result-document></xsl:template>
    
</xsl:stylesheet>