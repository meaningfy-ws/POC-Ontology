<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" exclude-result-prefixes="xd xsl dc fn"
    xmlns:cc="http://creativecommons.org/ns#" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:dct="http://purl.org/dc/terms/" xmlns:fn="http://www.w3.org/2005/xpath-functions"
    xmlns:functx="http://www.functx.com" xmlns:owl="http://www.w3.org/2002/07/owl#"
    xmlns:rdfs="http://www.w3.org/2000/01/rdf-schema#" xmlns:vann="http://purl.org/vocab/vann/"
    version="3.0">

    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Mar 22, 2020</xd:p>
            <xd:p><xd:b>Author:</xd:b> lps</xd:p>
            <xd:p>This module defines project level variables and parameters</xd:p>
        </xd:desc>
    </xd:doc>



    <!-- a set of prefix-baseURI definitions -->
    <xsl:variable name="namespacePrefixes" select="fn:doc('namespaces.xml')"/>

    <!-- a mapping between UML atomic types to XSD datatypes  -->
    <xsl:variable name="umlDataTypesMapping" select="fn:doc('umlToXsdDataTypes.xml')"/>

    <!-- XSD datatypes that conform to OWL2 requirements   -->
    <xsl:variable name="xsdAndRdfDataTypes" select="fn:doc('xsdAndRdfDataTypes.xml')"/>
    <!--    set default namespace interpretation for lexical Qnames that are not prefix:localSegment or :localSegment. If this
    is set to true localSegment will transform to :localSegment-->
    <xsl:variable name="defaultNamespaceInterpretation" select="fn:true()"/>

    <!-- Ontology base URI, configure as necessary. Do not use a trailing local delimiter
        like in the namespace definition-->
    <!--<xsl:variable name="base-uri" select="'http://publications.europa.eu/ontology/ePO'"/>-->
    <xsl:variable name="base-ontology-uri" select="'http://index.dev/ontology/rmo'"/>
    <xsl:variable name="base-shape-uri" select="'http://index.dev/ontology/rmo/data-shape'"/>
    <xsl:variable name="base-restriction-uri" select="$base-ontology-uri"/>
    <!--    Shapes Module URI-->
    <xsl:variable name="shapeArtefactURI"
        select="fn:concat($base-shape-uri, $defaultDelimiter, $moduleReference, '-shape')"/>
    <!--    Restrictions Module URI-->
    <xsl:variable name="restrictionsArtefactURI"
        select="fn:concat($base-restriction-uri, $defaultDelimiter, $moduleReference, '-restriction')"/>
    <!--    Core Module URI-->
    <xsl:variable name="coreArtefactURI"
        select="fn:concat($base-ontology-uri, $defaultDelimiter, $moduleReference)"/>

    <!-- when a delimiter is missing in the base URI of a namespace, use this default value-->
    <xsl:variable name="defaultDelimiter" select="'#'"/>

    <!-- types of elements and names for attribute types that are acceptable to produce object properties -->
    <xsl:variable name="acceptableTypesForObjectProperties"
        select="('epo:Identifier', 'rdfs:Literal')"/>
    <!--    the type of attributes which takes values from a controlled list-->
    <xsl:variable name="controlledListType" select="'epo:Code'"/>
    <!-- Acceptable stereotypes -->
    <xsl:variable name="stereotypeValidOnAttributes" select="()"/>
    <xsl:variable name="stereotypeValidOnObjects" select="()"/>
    <xsl:variable name="stereotypeValidOnGeneralisations"
        select="('Disjoint', 'Equivalent', 'Complete')"/>
    <xsl:variable name="stereotypeValidOnAssociations" select="()"/>
    <xsl:variable name="stereotypeValidOnDependencies" select="('Disjoint', 'disjoint', 'join')"/>
    <xsl:variable name="stereotypeValidOnClasses" select="('Abstract')"/>
    <xsl:variable name="stereotypeValidOnDatatypes" select="()"/>
    <xsl:variable name="stereotypeValidOnEnumerations" select="()"/>
    <xsl:variable name="stereotypeValidOnPackages" select="()"/>

    <xsl:variable name="abstractClassesStereotypes" select="('Abstract', 'abstract class', 'abstract')"/>

    <!--    This variable controls whether the enumeration items are transformed into skos concepts or ignored-->
    <xsl:variable name="enableGenerationOfSkosConcept" select="fn:false()"/>

    <!--    This variable controls whether the enumerations are transformed into skos schemes or ignored-->
    <xsl:variable name="enableGenerationOfConceptSchemes" select="fn:true()"/>

    <!--Allowed characters for a normalized string-->
    <xsl:variable name="allowedStrings" select="'^[\w\d-_:]+$'"/>

    <!--    Generate reused classes, attributes and connectors-->
    <xsl:variable name="generateReusedConcepts" select="fn:true()"/>


    <xsl:variable name="reference-to-external-classes-in-glossary" select="fn:true()"/>

    <xsl:variable name="generateObjectsAndRealisations" select="fn:true()"/>

    <xsl:variable name="conventionReportCopyrightText" select="'Meaningfy, 2024'"/>
    <xsl:variable name="conventionReportAuthor" select="'Meaningfy'"/>
    <xsl:variable name="conventionReportAuthorLocation" select="'Luxembourg'"/>
    <xsl:variable name="conventionReportAuthorWebsite" select="'https://meaningfy.ws/'"/>
    <xsl:variable name="conventionReportUMLModelName" select="'Recruitment '"/>

    <!-- _______________________________________________________________________   -->
    <!--                            METADATA SECTION                               -->
    <!-- _______________________________________________________________________   -->
    <!--    This section contains the variables used to build the ontology metadata-->
    <xsl:variable name="moduleReference" select="'tech'"/>
    <!--    rdfs:label -->
<xsl:variable name="ontologyLabelCore" select="'Core Recruitment Match Vocabulary - core'"/>
<xsl:variable name="ontologyLabelRestrictions" select="'Core Recruitment Match Vocabulary - core restrictions'"/>
<xsl:variable name="ontologyLabelShapes" select="'Core Recruitment Match Vocabulary - core shapes'"/>
    <!--    dct:title -->
    <xsl:variable name="ontologyTitleCore" select="'RMO Ontology  - core'"/>
    <xsl:variable name="ontologyTitleRestrictions" select="'RMO Ontology_AP Ontology - core restrictions'"/>
    <xsl:variable name="ontologyTitleShapes" select="'RMO _AP Ontology - core shapes'"/>
    <!--    dct:description-->
    <xsl:variable name="ontologyDescriptionCore"
        select="'The Recruitment Match Ontology core describes the concepts and properties representing the Recruitment domain. The provision of these semantics offers the basis for a common understanding of the domain for all stakeholders ensuring the quality of data exchange and transparency. The ontology restrictions are published in a separate artefact.'"/>
    <xsl:variable name="ontologyDescriptionRestrictions"
        select="'The RMO ontology is designed to facilitate the automatic matching of candidate profiles with job descriptions, enhancing the recruitment process for both recruiters and candidates. This ontology integrates key concepts such as skills, qualifications, experiences, job roles, and technologies, structured to improve job matching, career management, and labor market analysis..'"/>
    <xsl:variable name="ontologyDescriptionShapes"
        select="'The Recruitment Match Ontology core shapes provides the generic datashape specifications for the Recruitment Match Ontology core.'"/>
    <!--    rdfs:seeAlso -->
    <xsl:variable name="seeAlsoResources"
        select="
            'https://github.com/meaningfy-ws/rmo-ontology'"/>
    <!--    dct:issued-->
    <xsl:variable name="issuedDate" select="format-date(current-date(), '[Y0001]-[M01]-[D01]')"/>
    <!--    owl:incompatibleWith -->
    <xsl:variable name="incompatibleWith" select="'none'"/>
    <!--    owl:versionInfo -->
    <xsl:variable name="versionInfo" select="'1.0.0'"/>
    <!--    bibo:status-->
    <xsl:variable name="ontologyStatus" select="'Semantic Specification Release'"/>
    <!--    owl:priorVersion -->
    <xsl:variable name="priorVersion" select="'none'"/>
    <!--    vann:preferredNamespaceUri -->
    <xsl:variable name="preferredNamespaceUri" select="'http://index.dev/ontology/rmo#'"/>
    <!--    vann:preferredNamespacePrefix -->
    <xsl:variable name="preferredNamespacePrefix" select="'rmo'"/>
    <!--    dct:license-->
    <xsl:variable name="licenseLiteral" select="'© Meaningfy, 2024. Unless otherwise noted, the reuse of the Ontology is authorised under the Meaningfy  CC-BY 4.0.'"/>
    <!--    dct:created-->
    <xsl:variable name="createdDate" select="'2024-07-01'"/>
    <!--    dct:publisher-->
    <xsl:variable name="publisher" select="'https://meaningfy.ws/'"/>

            <!-- _______________________________________________________________________   -->
    <!--                            RESPEC SECTION                               -->
    <!-- _______________________________________________________________________   -->

    <xsl:variable name="githubURL" select="'https://github.com/meaningfy-ws/rmo-ontology'"/>
    <xsl:variable name="respecDescription" select="'The RMO ontology is designed to facilitate the automatic matching of candidate profiles with job descriptions, enhancing the recruitment process for both recruiters and candidates. This ontology integrates key concepts such as skills, qualifications, experiences, job roles, and technologies, structured to improve job matching, career management, and labor market analysis. '"/>
    <xsl:variable name="feedbackURL" select="fn:concat($githubURL, '/issues')"/>
    <xsl:variable name="authors" select="('Andi Stan','Eugene Garla','Mihai Golovatenco', 'Eugen Costezki', 'Achilles Dougalis', 'Jana Ahmad')"/>
    <xsl:variable name="editors" select="('Jana Ahmad','Achilles Dougalis')"/>
</xsl:stylesheet>