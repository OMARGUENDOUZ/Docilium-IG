<?xml version="1.0" encoding="UTF-8"?>
<sch:schema xmlns:sch="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2">
  <sch:ns prefix="f" uri="http://hl7.org/fhir"/>
  <sch:ns prefix="h" uri="http://www.w3.org/1999/xhtml"/>
  <!-- 
    This file contains just the constraints for the profile ResearchStudy
    It includes the base constraints for the resource as well.
    Because of the way that schematrons and containment work, 
    you may need to use this schematron fragment to build a, 
    single schematron that validates contained resources (if you have any) 
  -->
  <sch:pattern>
    <sch:title>f:ResearchStudy</sch:title>
    <sch:rule context="f:ResearchStudy">
      <sch:assert test="count(f:identifier) &gt;= 1">identifier: minimum cardinality of 'identifier' is 1</sch:assert>
      <sch:assert test="count(f:identifier) &lt;= 3">identifier: maximum cardinality of 'identifier' is 3</sch:assert>
      <sch:assert test="count(f:title) &gt;= 1">title: minimum cardinality of 'title' is 1</sch:assert>
      <sch:assert test="count(f:phase) &gt;= 1">phase: minimum cardinality of 'phase' is 1</sch:assert>
      <sch:assert test="count(f:classifier) &gt;= 1">classifier: minimum cardinality of 'classifier' is 1</sch:assert>
      <sch:assert test="count(f:associatedParty) &gt;= 1">associatedParty: minimum cardinality of 'associatedParty' is 1</sch:assert>
      <sch:assert test="count(f:recruitment) &gt;= 1">recruitment: minimum cardinality of 'recruitment' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
  <sch:pattern>
    <sch:title>f:ResearchStudy/f:recruitment</sch:title>
    <sch:rule context="f:ResearchStudy/f:recruitment">
      <sch:assert test="count(f:targetNumber) &gt;= 1">targetNumber: minimum cardinality of 'targetNumber' is 1</sch:assert>
      <sch:assert test="count(f:actualNumber) &gt;= 1">actualNumber: minimum cardinality of 'actualNumber' is 1</sch:assert>
    </sch:rule>
  </sch:pattern>
</sch:schema>
