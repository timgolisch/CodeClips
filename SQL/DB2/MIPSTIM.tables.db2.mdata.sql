--  Generate SQL 
--  Written on:              	3/25/2008 2:55 PM
--  Relational Database:       	MDATA
--  Standards Option:          	DB2 UDB iSeries 

/**** Set up the journaling before creating tables ***/
--first, create a journal Receiver
--CALL QSYS.CRTJRNRCV JRNRCV(MIPSTIM/jrcDefault) THRESHOLD(100000) TEXT('Default Receiver')
--create a journal 
--CALL QSYS.CRTJRN JRN(MIPSTIM/jrnDefault), JRNRCV(MIPSTIM/jrcDefault) MNGRCV(*SYSTEM) DLTRCV(*YES) TEXT('Default Journal')

--SELECT Max(athID) AS PK FROM Mipstim.tbActivityHistoryType;

DROP TABLE MDATA.tbActivityHistoryType;
---------------------------------------------------------------------------
-- tbActivityHistoryType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.ACTHISTTYP --tbActivityHistoryType 
( 
	athID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	athDescription FOR COLUMN DESCRIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	athModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	athModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	athActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbActivityHistoryType PRIMARY KEY( athID )
);

/* Setting label text for tbActivityHistoryType */
LABEL ON TABLE MDATA.ACTHISTTYP IS 'tbActivityHistoryType' ;

/* Setting table (Long) name for tbActivityHistoryType (ACTHISTTYP) */
RENAME TABLE MDATA.ACTHISTTYP TO tbActivityHistoryType FOR SYSTEM NAME ACTHISTTYP;

--start journaling this table
--EXEC STRJRNPF  FILE(MDATA/tbActivityHistoryType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO


--SELECT MAX(BATID) AS PK FROM MDATA.TBBATCH;

DROP TABLE MDATA.tbBatch ;COMMIT;
---------------------------------------------------------------------------
-- tbBatch 
---------------------------------------------------------------------------
CREATE TABLE MDATA.BATCH --tbBatch 
( 
	batID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 85 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	batWorkStationName FOR COLUMN MACHINENAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	batClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	batStatus FOR COLUMN BATCHSTAT CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	batDateOfService FOR COLUMN DATEOFSVC CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	batModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	batModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	batActive FOR COLUMN ACTIVE INTEGER NOT NULL DEFAULT 0, 
	CONSTRAINT MDATA.PK_tbBatch PRIMARY KEY( batID )
);

/* Setting label text for tbBatch */
LABEL ON TABLE MDATA.BATCH IS 'tbBatch' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbBatch FOR MDATA.BATCH;


--start journaling this table
--EXEC STRJRNPF  FILE(MDATA/tbBatch)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(blsID ) AS PK FROM MDATA.tbBillingSource ;

DROP TABLE MDATA.tbBillingSource ;
---------------------------------------------------------------------------
-- tbBillingSource 
---------------------------------------------------------------------------
CREATE TABLE MDATA.BILLSRC --tbBillingSource 
( 
	blsID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 24 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	blsCode FOR COLUMN BSRCCODE CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	blsDescription FOR COLUMN DESCRIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	blsHealthInsurance FOR COLUMN HEALTHINS CHAR(1) NOT NULL DEFAULT ' ', 
	blsWorkersComp FOR COLUMN WORKERCOMP CHAR(1) NOT NULL DEFAULT ' ', 
	blsAutoAccident FOR COLUMN AUTOACC CHAR(1) NOT NULL DEFAULT ' ', 
	blsPublicLiability FOR COLUMN PUBLIAB CHAR(1) NOT NULL DEFAULT ' ', 
	blsRangeBegin FOR COLUMN RANGEBEGIN INTEGER NOT NULL DEFAULT 0, 
	blsRangeEnd FOR COLUMN RANGEEND INTEGER NOT NULL DEFAULT 0, 
	blsModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	blsModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	blsActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	blsBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	blsEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbBillingSource PRIMARY KEY( blsID )
);

/* Setting label text for tbBillingSource */
LABEL ON TABLE MDATA.BILLSRC IS 'tbBillingSource' ;

/* Setting table (Long) name for tbBillingSource (BILLSRC) */
RENAME TABLE MDATA.BILLSRC TO tbBillingSource FOR SYSTEM NAME BILLSRC;

--start journaling this table
--EXEC STRJRNPF  FILE(tbBillingSource)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(sccID ) AS PK FROM MDATA.tbCDFCC ;

DROP TABLE MDATA.CDFCC ;
---------------------------------------------------------------------------
-- tbCDFCC 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CDFCC --tbCDFCC 
( 
	sccID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1251 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	sccClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	sccCostCenter_csbID FOR COLUMN FK_CSBID INTEGER NOT NULL DEFAULT 0, 
	sccBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sccEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sccModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sccModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	sccActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbCDFCC PRIMARY KEY( sccID )
);

/* Setting label text for tbCDFCC */
LABEL ON TABLE MDATA.CDFCC IS 'tbCDFCC' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbCDFCC FOR MDATA.CDFCC;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCDFCC)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(criID ) AS PK FROM MDATA.tbCDFGI ;

DROP TABLE MDATA.CDFGI ;
---------------------------------------------------------------------------
-- tbCDFGI 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CDFGI --tbCDFGI 
( 
	criID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 243 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	criClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	criInsuranceID_insID FOR COLUMN FK_INSID INTEGER NOT NULL DEFAULT 0, 
	criGroupNumber FOR COLUMN GROUPNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	criBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	criEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	criParticipation FOR COLUMN PARTICIP CHAR(1) NOT NULL DEFAULT ' ', 
	criProviderNumberRequired FOR COLUMN PRVNUMREQD CHAR(1) NOT NULL DEFAULT ' ', 
	criGroupNumberRequired FOR COLUMN GRPNOREQD CHAR(1) NOT NULL DEFAULT ' ', 
	criModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	criModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	criActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbCDFGI PRIMARY KEY( criID )
);

/* Setting label text for tbCDFGI */
LABEL ON TABLE MDATA.CDFGI IS 'tbCDFGI' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbCDFGI FOR MDATA.CDFGI;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCDFGI)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(cliID ) AS PK FROM MDATA.tbCdfMI ;

DROP TABLE MDATA.CdfMI ;
DROP ALIAS MDATA.tbCdfMI; 
---------------------------------------------------------------------------
-- tbCdfMI 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CDFMI --tbCdfMI 
( 
	cliID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 160 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	cliClientType_ctyID FOR COLUMN FK_CTYID INTEGER NOT NULL DEFAULT 0, 
	cliClientState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	cliFederalEmployerIdentityNumber FOR COLUMN FEDEMPIDNO CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	cliStateCorporationNumber FOR COLUMN STCORPNO CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	cliNPI FOR COLUMN NPI CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	cliClientName FOR COLUMN CLIENTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cliBusinessAddress FOR COLUMN BUSADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cliBusinessCity FOR COLUMN BUSCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	cliBusinessState_staID FOR COLUMN FK_STAID_B INTEGER NOT NULL DEFAULT 0, 
	cliBusinessZipcode FOR COLUMN BUSZIP CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	cliBusinessAcceptAddress FOR COLUMN BUSADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cliBusinessTelephone FOR COLUMN BUSPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	cliMultiSite FOR COLUMN MULTISITE CHAR(1) NOT NULL DEFAULT ' ', 
	cliEndProcessingDate FOR COLUMN ENDPROCDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	cliInvoiceAddress FOR COLUMN INVADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cliInvoiceDeptNumber FOR COLUMN INVDEPTNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cliInvoiceCity FOR COLUMN INVCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	cliInvoiceState_staID FOR COLUMN FK_STAID_I INTEGER NOT NULL DEFAULT 0, 
	cliInvoiceZipCode FOR COLUMN INVZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	cliInvoiceAcceptAddress FOR COLUMN INVADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cliInvoiceTelephone FOR COLUMN INVPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	cliInvoiceEmail FOR COLUMN INVEMAIL CHAR(70) CCSID 37 NOT NULL DEFAULT ' ',
	cliStopInvoicingDate FOR COLUMN STOPINVDAT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	cliBankName FOR COLUMN BANKNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cliBankTelephone FOR COLUMN BANKPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	cliElectronicRegistryExists FOR COLUMN REGEXISTS CHAR(1) NOT NULL DEFAULT ' ', 
	cliBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	cliEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	cliRvuRegion FOR COLUMN RVUREGION DECIMAL(5,3) NOT NULL DEFAULT 0, 
	cliPurgePatientDemographics FOR COLUMN PURGPNTDEM CHAR(1) NOT NULL DEFAULT ' ', 
	cliPurgeClaims FOR COLUMN PURGECLAIM CHAR(1) NOT NULL DEFAULT 'N', 
	cliModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	cliModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	cliActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbCdfMI PRIMARY KEY( cliID )
);

/* Setting label text for tbCdfMI */
LABEL ON TABLE MDATA.CDFMI IS 'tbCdfMI' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbCdfMI FOR MDATA.CDFMI;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCdfMI)  JRN(MIPSTIM/JRNLDEFAULT)
--GO


--SELECT MAX(pvdID ) AS PK FROM MDATA.tbCDFPI ;

DROP TABLE MDATA.CDFPI ;
---------------------------------------------------------------------------
-- tbCDFPI 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CDFPI --tbCDFPI 
( 
	pvdID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 22159 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pvdClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	pvdProviderType_pvtID FOR COLUMN FK_PVTID INTEGER NOT NULL DEFAULT 0, 
	pvdFirstName FOR COLUMN FIRSTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvdLastName FOR COLUMN LASTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvdSocialSecurityNumber FOR COLUMN SSN INTEGER NOT NULL DEFAULT 0, 
	pvdEMail FOR COLUMN EMAILADDR CHAR(70) CCSID 37 NOT NULL DEFAULT ' ',
	pvdProviderStatus_pvsID FOR COLUMN FK_PVSID INTEGER NOT NULL DEFAULT 0, 
	pvdInternalNumber FOR COLUMN INTERNALNO INTEGER NOT NULL DEFAULT 0, 
	pvdProviderPayrollCode_sccID FOR COLUMN FK_SCCID INTEGER NOT NULL DEFAULT 0, 
	pvdMedicalLicenseNumber FOR COLUMN MEDLICNUM CHAR(7) CCSID 37 NOT NULL DEFAULT ' ',
	pvdMedicalLicenseExpiryDate FOR COLUMN MEDLCEXPDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pvdUserID FOR COLUMN USERID CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvdPassword FOR COLUMN PASSWRD CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvdPasswordClue FOR COLUMN PWCLUE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvdBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pvdEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pvdLocumTenon_pvdID FOR COLUMN FK_PVDID INTEGER NOT NULL DEFAULT 0, 
	pvdNationalProviderID FOR COLUMN NATLPRVID CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	pvdUPIN FOR COLUMN UPIN CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	pvdModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pvdModifiedBy_UsrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pvdActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbCDFPI PRIMARY KEY( pvdID )
);

/* Setting label text for tbCDFPI */
LABEL ON TABLE MDATA.CDFPI IS 'tbCDFPI' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbCDFPI FOR MDATA.CDFPI;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCDFPI)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(sbdID ) AS PK FROM MDATA.tbCDFSchoolBuilding ;

DROP TABLE MDATA.tbCDFSchoolBuilding ;
---------------------------------------------------------------------------
-- tbCDFSchoolBuilding 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CDFSCHBLDG --tbCDFSchoolBuilding 
( 
	sbdID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1056 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	sbdCostCenter_csbID FOR COLUMN FK_CSBID INTEGER NOT NULL DEFAULT 0, 
	sbdSchoolNumber FOR COLUMN SCHOOLNUM CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	sbdName FOR COLUMN SCHOOLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	sbdAddress FOR COLUMN SCHOOLADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	sbdCity FOR COLUMN SCHOOLCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	sbdState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	sbdZipcode FOR COLUMN ZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	sbdAcceptAddress FOR COLUMN ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	sbdModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sbdModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	sbdActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	sbdBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sbdEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbCDFSchoolBuilding PRIMARY KEY( sbdID )
);

/* Setting label text for tbCDFSchoolBuilding */
LABEL ON TABLE MDATA.CDFSCHBLDG IS 'tbCDFSchoolBuilding' ;

/* Setting table (Long) name for tbCDFSchoolBuilding (CDFSCHBLDG) */
RENAME TABLE MDATA.CDFSCHBLDG TO tbCDFSchoolBuilding FOR SYSTEM NAME CDFSCHBLDG;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCDFSchoolBuilding)  JRN(MIPSTIM/JRNLDEFAULT)
--GO


--SELECT MAX(clhID ) AS PK FROM MDATA.tbClaimHoldingFile ;

DROP TABLE MDATA.tbClaimHoldingFile ;
---------------------------------------------------------------------------
-- tbClaimHoldingFile 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CLAIMHLDFL --tbClaimHoldingFile 
( 
	clhID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	clhPatient_patID FOR COLUMN FK_PATID INTEGER NOT NULL DEFAULT 0, 
	clhRegistry_regid FOR COLUMN FK_REGID INTEGER NOT NULL DEFAULT 0, 
	clhClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	clhWorkstationID FOR COLUMN MACHINEID CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhStandardRegistry_shrID FOR COLUMN FK_SHRID INTEGER NOT NULL DEFAULT 0, 
	clhNewLastName FOR COLUMN NEWLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewFirstName FOR COLUMN NEWFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGender FOR COLUMN NEWGENDER CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewDOB FOR COLUMN NEWDOB CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	clhNewAddress FOR COLUMN NEWADDRESS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewCity FOR COLUMN NEWCITY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewState_staID FOR COLUMN FK_STAID_N INTEGER NOT NULL DEFAULT 0, 
	clhNewZipcode FOR COLUMN NEWZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewAcceptAddress FOR COLUMN NEWADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewTelephone FOR COLUMN NEWPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewSSN FOR COLUMN NEWSSN CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewMedicaid FOR COLUMN NEWMA CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewMedicare FOR COLUMN NEWMC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarLastName FOR COLUMN NEWGUARLNM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarFirstName FOR COLUMN NEWGUARFNM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarAddress FOR COLUMN NEWGUARADR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarCity FOR COLUMN NEWGUARCTY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarState_staID FOR COLUMN FK_STAID_G INTEGER NOT NULL DEFAULT 0, 
	clhNewGuarZipcode FOR COLUMN NEWGUARZIP CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarAcceptAddress FOR COLUMN NWGURADROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	clhNewGuarRelationship_relID FOR COLUMN FK_RELID INTEGER NOT NULL DEFAULT 0, 
	clhAdmitDate FOR COLUMN ADMITDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	clhTriageTime FOR COLUMN TRIAGETIME INTEGER NOT NULL DEFAULT 0, 
	clhRenderingProvider_prvID FOR COLUMN FK_PRVID_N INTEGER NOT NULL DEFAULT 0, 
	clhRenderingProviderName FOR COLUMN RNDRPRVNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhReferingProvider_prvID FOR COLUMN FK_PRVID_F INTEGER NOT NULL DEFAULT 0, 
	clhReferingProviderName FOR COLUMN REFRPRVNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhCostCenter_cerID FOR COLUMN FK_CERID INTEGER NOT NULL DEFAULT 0, 
	clhCostCenterName FOR COLUMN COSTCTRNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhAuthTreatNumber FOR COLUMN AUTHTREATN CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhChiefComplaint FOR COLUMN CHIEFCOMPL CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhComment FOR COLUMN CHFCOMMENT CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhFileName FOR COLUMN CHFFILENAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	clhModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	clhModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	clhActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbClaimHoldingFile PRIMARY KEY( clhID )
);

/* Setting label text for tbClaimHoldingFile */
LABEL ON TABLE MDATA.CLAIMHLDFL IS 'tbClaimHoldingFile' ;

/* Setting table (Long) name for tbClaimHoldingFile (CLAIMHLDFL) */
RENAME TABLE MDATA.CLAIMHLDFL TO tbClaimHoldingFile FOR SYSTEM NAME CLAIMHLDFL;

--start journaling this table
--EXEC STRJRNPF  FILE(tbClaimHoldingFile)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(stsID ) AS PK FROM MDATA.tbClaimStatus ;

DROP TABLE MDATA.tbClaimStatus ;
---------------------------------------------------------------------------
-- tbClaimStatus 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CLAIMSTAT --tbClaimStatus 
( 
	stsID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 6 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	stsDescription FOR COLUMN DESCRIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stsModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	stsModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	stsActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbClaimStatus PRIMARY KEY( stsID )
);

/* Setting label text for tbClaimStatus */
LABEL ON TABLE MDATA.CLAIMSTAT IS 'tbClaimStatus' ;

/* Setting table (Long) name for tbClaimStatus (CLAIMSTAT) */
RENAME TABLE MDATA.CLAIMSTAT TO tbClaimStatus FOR SYSTEM NAME CLAIMSTAT;

--start journaling this table
--EXEC STRJRNPF  FILE(tbClaimStatus)  JRN(MIPSTIM/JRNLDEFAULT)
--GO


--SELECT MAX(ccmID ) AS PK FROM MDATA.tbClientChargeMaster ;

DROP TABLE MDATA.tbClientChargeMaster ;
---------------------------------------------------------------------------
-- tbClientChargeMaster 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CLICHGMSTR --tbClientChargeMaster 
( 
	ccmID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 4635 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ccmClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	ccmProcedureID_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	ccmAmount FOR COLUMN CHRGAMOUNT DECIMAL(7,2) NOT NULL DEFAULT 0, 
	ccmModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ccmModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ccmActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbClientChargeMaster PRIMARY KEY( ccmID )
);

/* Setting label text for tbClientChargeMaster */
LABEL ON TABLE MDATA.CLICHGMSTR IS 'tbClientChargeMaster' ;

/* Setting table (Long) name for tbClientChargeMaster (CLICHGMSTR) */
RENAME TABLE MDATA.CLICHGMSTR TO tbClientChargeMaster FOR SYSTEM NAME CLICHGMSTR;

--start journaling this table
--EXEC STRJRNPF  FILE(tbClientChargeMaster)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ctyID ) AS PK FROM MDATA.tbClientType ;

DROP TABLE MDATA.tbClientType ;
---------------------------------------------------------------------------
-- tbClientType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.CLITYPE --tbClientType 
( 
	ctyID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 45 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ctyClientTypeAbbreviation FOR COLUMN CLITYPABBR CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	ctyClientTypeDescription FOR COLUMN CLITYPDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ctyTaxonomy FOR COLUMN TAXONOMY CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	ctyModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ctyModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ctyActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	ctyBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ctyEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbClientType PRIMARY KEY( ctyID )
);

/* Setting label text for tbClientType */
LABEL ON TABLE MDATA.CLITYPE IS 'tbClientType' ;

/* Setting table (Long) name for tbClientType (CLITYPE) */
RENAME TABLE MDATA.CLITYPE TO tbClientType FOR SYSTEM NAME CLITYPE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbClientType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO




--SELECT MAX(csbID ) AS PK FROM MDATA.tbCostCenter ;

drop table MDATA.tbcostcenter; commit;
---------------------------------------------------------------------------
-- tbCostCenter 
---------------------------------------------------------------------------
CREATE TABLE MDATA.COSTCENTER --tbCostCenter 
( 
	csbID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 840 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	csbLEANumber FOR COLUMN LEANUMBER CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	csbPOSID_posID FOR COLUMN FK_POSID INTEGER NOT NULL DEFAULT 0, 
	csbFacilityName FOR COLUMN FACILTYNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	csbName FOR COLUMN CCNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	csbAddress FOR COLUMN CCADDRESS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	csbCity FOR COLUMN CCCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	csbState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	csbAcceptAddress FOR COLUMN ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	csbEmailAddress FOR COLUMN EMAILADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	csbPhoneNumber FOR COLUMN PHONENUM CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	csbZipCode FOR COLUMN ZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	csbNPINumber FOR COLUMN NPINUMBER CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	csbBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	csbEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	csbModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	csbModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	csbActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbCostCenter PRIMARY KEY( csbID )
);

/* Setting label text for tbCostCenter */
LABEL ON TABLE MDATA.COSTCENTER IS 'tbCostCenter' ;

/* Setting table (Long) name for tbCostCenter (COSTCENTER) */
RENAME TABLE MDATA.COSTCENTER TO tbCostCenter FOR SYSTEM NAME COSTCENTER;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCostCenter)  JRN(MIPSTIM/JRNLDEFAULT)
--GO


--SELECT MAX(cntID ) AS PK FROM MDATA.tbCountry ;

DROP TABLE MDATA.Country ;
---------------------------------------------------------------------------
-- tbCountry 
---------------------------------------------------------------------------
CREATE TABLE MDATA.COUNTRY --tbCountry 
( 
	cntID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 4 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	cntCountryName FOR COLUMN COUNTRYNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cntModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	cntModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	cntActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	cntAbbreviation FOR COLUMN ABBR CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	CONSTRAINT MDATA.PK_tbCountry PRIMARY KEY( cntID )
);

/* Setting label text for tbCountry */
LABEL ON TABLE MDATA.COUNTRY IS 'tbCountry' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbCountry FOR MDATA.COUNTRY;

--start journaling this table
--EXEC STRJRNPF  FILE(tbCountry)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ddfID ) AS PK FROM MDATA.tbDepositDetail ;

DROP TABLE MDATA.tbDepositDetail ;
---------------------------------------------------------------------------
-- tbDepositDetail 
---------------------------------------------------------------------------
CREATE TABLE MDATA.DEPOSITDTL --tbDepositDetail 
( 
	ddfID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ddfClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	ddfDepositDate FOR COLUMN DEPOSITDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ddfReceivedDate FOR COLUMN RCVDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ddfDepositAmount FOR COLUMN DEPOSITAMT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	ddfDepositType_ddtID FOR COLUMN FK_DDTID INTEGER NOT NULL DEFAULT 0, 
	ddfModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ddfModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ddfActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbDepositDetail PRIMARY KEY( ddfID )
);

/* Setting label text for tbDepositDetail */
LABEL ON TABLE MDATA.DEPOSITDTL IS 'tbDepositDetail' ;

/* Setting table (Long) name for tbDepositDetail (DEPOSITDTL) */
RENAME TABLE MDATA.DEPOSITDTL TO tbDepositDetail FOR SYSTEM NAME DEPOSITDTL;

--start journaling this table
--EXEC STRJRNPF  FILE(tbDepositDetail)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ddtID ) AS PK FROM MDATA.tbDepositType ;

DROP TABLE MDATA.tbDepositType ;
---------------------------------------------------------------------------
-- tbDepositType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.DEPOSITTYP --tbDepositType 
(
	ddtID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ddtCode FOR COLUMN DTYPCODE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ddtDescription FOR COLUMN DTYPDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ddtModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ddtModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ddtActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbDepositType PRIMARY KEY( ddtID )
);

/* Setting label text for tbDepositType */
LABEL ON TABLE MDATA.DEPOSITTYP IS 'tbDepositType' ;

/* Setting table (Long) name for tbDepositType (DEPOSITTYP) */
RENAME TABLE MDATA.DEPOSITTYP TO tbDepositType FOR SYSTEM NAME DEPOSITTYP;

--start journaling this table
--EXEC STRJRNPF  FILE(tbDepositType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(dicID ) AS PK FROM MDATA.tbDiagnosisCode ;

DROP TABLE MDATA.tbDiagnosisCode ;
---------------------------------------------------------------------------
-- tbDiagnosisCode 
---------------------------------------------------------------------------
CREATE TABLE MDATA.DXCODE --tbDiagnosisCode 
( 
	dicID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 343 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	dicDX_whoID FOR COLUMN FK_WHOID INTEGER NOT NULL DEFAULT 0, 
	dicMBCDescription FOR COLUMN MBCDESC CHAR(240) CCSID 37 NOT NULL DEFAULT ' ',
	dicSchoolBased FOR COLUMN SCHOOLBASD CHAR(1) NOT NULL DEFAULT ' ', 
	dicProfessional FOR COLUMN PROFESNL CHAR(1) NOT NULL DEFAULT ' ', 
	dicProfessionalEmergency FOR COLUMN PROEMRGNCY CHAR(1) NOT NULL DEFAULT ' ', 
	dicInjury FOR COLUMN INJURY CHAR(1) NOT NULL DEFAULT ' ', 
	dicCriticalCare FOR COLUMN CRITCLCARE CHAR(1) NOT NULL DEFAULT ' ', 
	dicWorkRelated FOR COLUMN WORKRELATD CHAR(1) NOT NULL DEFAULT ' ', 
	dicProfessionalEndDate FOR COLUMN PROENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	dicSchoolBasedEndDate FOR COLUMN SBENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	dicBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01',
	dicModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	dicModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	dicActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbDiagnosisCode PRIMARY KEY( dicID )
);

/* Setting label text for tbDiagnosisCode */
LABEL ON TABLE MDATA.DXCODE IS 'tbDiagnosisCode' ;

/* Setting table (Long) name for tbDiagnosisCode (DXCODE) */
RENAME TABLE MDATA.DXCODE TO tbDiagnosisCode FOR SYSTEM NAME DXCODE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbDiagnosisCode)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(whoID ) AS PK FROM MDATA.tbDiagnosisCodeMaster ;

DROP TABLE MDATA.tbDiagnosisCodeMaster ;
---------------------------------------------------------------------------
-- tbDiagnosisCodeMaster 
---------------------------------------------------------------------------
CREATE TABLE MDATA.DXCDMASTER --tbDiagnosisCodeMaster 
( 
	whoID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 14162 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	whoCode FOR COLUMN DCMCODE CHAR(5) CCSID 37 NOT NULL DEFAULT ' ',
	whoDescription FOR COLUMN DCMDESC CHAR(240) CCSID 37 NOT NULL DEFAULT ' ',
	whoSubdivision FOR COLUMN SUBDIVISN CHAR(1) NOT NULL DEFAULT ' ', 
	whoMRILOC CHAR(1) NOT NULL DEFAULT 'N',
	whoModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	whoModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	whoActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbDiagnosisCodeMaster PRIMARY KEY( whoID )
);

/* Setting label text for tbDiagnosisCodeMaster */
LABEL ON TABLE MDATA.DXCDMASTER IS 'tbDiagnosisCodeMaster' ;

/* Setting table (Long) name for tbDiagnosisCodeMaster (DXCDMASTER) */
RENAME TABLE MDATA.DXCDMASTER TO tbDiagnosisCodeMaster FOR SYSTEM NAME DXCDMASTER;

--start journaling this table
--EXEC STRJRNPF  FILE(tbDiagnosisCodeMaster)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(usrID ) AS PK FROM MDATA.tbEmployeeProfile ;

DROP TABLE MDATA.tbEmployeeProfile ;
---------------------------------------------------------------------------
-- tbEmployeeProfile 
---------------------------------------------------------------------------
CREATE TABLE MDATA.EMPPROFILE --tbEmployeeProfile 
( 
	usrID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 16148 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	usrLastname FOR COLUMN LASTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	usrFirstname FOR COLUMN FIRSTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	usrBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	usrEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	usrUserName FOR COLUMN USERNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	usrPassword FOR COLUMN PASSWRD CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	usrOldPassword FOR COLUMN OLDPW CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	usrPasswordChangeDate FOR COLUMN PWCHANGEDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	usrModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	usrModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	usrActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbEmployeeProfile PRIMARY KEY( usrID )
);

/* Setting label text for tbEmployeeProfile */
LABEL ON TABLE MDATA.EMPPROFILE IS 'tbEmployeeProfile' ;

/* Setting table (Long) name for tbEmployeeProfile (EMPPROFILE) */
RENAME TABLE MDATA.EMPPROFILE TO tbEmployeeProfile FOR SYSTEM NAME EMPPROFILE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbEmployeeProfile)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(eurID ) AS PK FROM MDATA.tbEmployeeUserRole ;

DROP TABLE MDATA.tbEmployeeUserRole ;
---------------------------------------------------------------------------
-- tbEmployeeUserRole 
---------------------------------------------------------------------------
CREATE TABLE MDATA.EMPUSRROLE --tbEmployeeUserRole 
( 
	eurID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 8105 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	eurUser_usrID FOR COLUMN FK_USRID INTEGER NOT NULL DEFAULT 0, 
	eurRole_rolID FOR COLUMN FK_ROLID INTEGER NOT NULL DEFAULT 0, 
	eurProviderID_pvdID FOR COLUMN FK_PVDID INTEGER NOT NULL DEFAULT 0, 
	eurBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	eurEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	eurModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	eurModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	eurActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbEmployeeUserRole PRIMARY KEY( eurID )
);

/* Setting label text for tbEmployeeUserRole */
LABEL ON TABLE MDATA.EMPUSRROLE IS 'tbEmployeeUserRole' ;

/* Setting table (Long) name for tbEmployeeUserRole (EMPUSRROLE) */
RENAME TABLE MDATA.EMPUSRROLE TO tbEmployeeUserRole FOR SYSTEM NAME EMPUSRROLE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbEmployeeUserRole)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ffpID ) AS PK FROM MDATA.tbFederalFundsPortion ;

DROP TABLE MDATA.tbFederalFundsPortion ;
---------------------------------------------------------------------------
-- tbFederalFundsPortion 
---------------------------------------------------------------------------
CREATE TABLE MDATA.FEDFUNDSPN --tbFederalFundsPortion 
( 
	ffpID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 17 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ffpState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	ffpFFPRate FOR COLUMN FFPRATE DECIMAL(7,4) NOT NULL DEFAULT 0, 
	ffpFiscalYearStart FOR COLUMN FSCYRSTART CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ffpFiscalYearEnd FOR COLUMN FISCYREND CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ffpModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ffpModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ffpActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbFederalFundsPortion PRIMARY KEY( ffpID )
);

/* Setting label text for tbFederalFundsPortion */
LABEL ON TABLE MDATA.FEDFUNDSPN IS 'tbFederalFundsPortion' ;

/* Setting table (Long) name for tbFederalFundsPortion (FEDFUNDSPN) */
RENAME TABLE MDATA.FEDFUNDSPN TO tbFederalFundsPortion FOR SYSTEM NAME FEDFUNDSPN;

--start journaling this table
--EXEC STRJRNPF  FILE(tbFederalFundsPortion)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(insID ) AS PK FROM MDATA.tbInsuranceMaster ;

drop table MDATA.tbinsurancemaster; commit;
---------------------------------------------------------------------------
-- tbInsuranceMaster 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INSMASTER --tbInsuranceMaster 
( 
	insID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 830 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	insName  CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	insFederalInsuranceNumber FOR COLUMN FEDINSNUM CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	insNumber FOR COLUMN INSNUMBR CHAR(4) CCSID 37 NOT NULL DEFAULT ' ',
	insAddress FOR COLUMN INSADDRSS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	insCity CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	insState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	insZipcode FOR COLUMN ZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	insAcceptAddress FOR COLUMN ACCEPTADDR CHAR(1) NOT NULL DEFAULT ' ',
	insTelephone FOR COLUMN TELEPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	insEmailAddress FOR COLUMN EMAILADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	insOCNA FOR COLUMN OCNA CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	insClearingHouseNumber FOR COLUMN CLRNGHSNUM CHAR(5) CCSID 37 NOT NULL DEFAULT ' ',
	insClearingHousePayerNumber FOR COLUMN CLRHSPAYNO CHAR(5) CCSID 37 NOT NULL DEFAULT ' ',
	insBillSrc_blsID FOR COLUMN FK_BLSID INTEGER NOT NULL DEFAULT 0, 
	insElectronicCapable FOR COLUMN ELECCAPABL CHAR(1) NOT NULL DEFAULT ' ', 
	insModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	insModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	insActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	insBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	insEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbInsuranceMaster PRIMARY KEY( insID )
);

/* Setting label text for tbInsuranceMaster */
LABEL ON TABLE MDATA.INSMASTER IS 'tbInsuranceMaster' ;

/* Setting table (Long) name for tbInsuranceMaster (INSMASTER) */
RENAME TABLE MDATA.INSMASTER TO tbInsuranceMaster FOR SYSTEM NAME INSMASTER;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInsuranceMaster)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ipmID ) AS PK FROM MDATA.tbInsurancePaymentMaster ;

DROP TABLE MDATA.tbInsurancePaymentMaster ;
---------------------------------------------------------------------------
-- tbInsurancePaymentMaster 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INSPMTMAST --tbInsurancePaymentMaster 
( 
	ipmID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ipmProcedureCode_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	ipmInsuranceID_insID FOR COLUMN FK_INSID INTEGER NOT NULL DEFAULT 0, 
	ipmClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	ipmCharge FOR COLUMN CHARGEAMT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	ipmModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ipmModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ipmActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbInsurancePaymentMaster PRIMARY KEY( ipmID )
);

/* Setting label text for tbInsurancePaymentMaster */
LABEL ON TABLE MDATA.INSPMTMAST IS 'tbInsurancePaymentMaster' ;

/* Setting table (Long) name for tbInsurancePaymentMaster (INSPMTMAST) */
RENAME TABLE MDATA.INSPMTMAST TO tbInsurancePaymentMaster FOR SYSTEM NAME INSPMTMAST;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInsurancePaymentMaster)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(iadID ) AS PK FROM MDATA.tbInvoiceAncDetail ;

DROP TABLE MDATA.tbInvoiceAncDetail ;
---------------------------------------------------------------------------
-- tbInvoiceAncDetail 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INVANCDETL --tbInvoiceAncDetail 
( 
	iadID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 4 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	iadBatch_batID FOR COLUMN FK_BATID INTEGER NOT NULL DEFAULT 0, 
	iadPatient_patID FOR COLUMN FK_PATID INTEGER NOT NULL DEFAULT 0, 
	iadStudent_stuID FOR COLUMN FK_STUID INTEGER NOT NULL DEFAULT 0, 
	iadCostCenter_sccID FOR COLUMN FK_SCCID INTEGER NOT NULL DEFAULT 0, 
	iadEncounterNumber FOR COLUMN ENCNUM CHAR(17) CCSID 37 NOT NULL DEFAULT ' ',
	iadDateOfService FOR COLUMN DATEOFSVC CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iadTriageTime FOR COLUMN TRIAGETIME CHAR(4) CCSID 37 NOT NULL DEFAULT ' ',
	iadAdmitTime FOR COLUMN ADMITTIME CHAR(4) CCSID 37 NOT NULL DEFAULT ' ',
	iadAdmitDate FOR COLUMN ADMITDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iadRenderProvider_pvdID FOR COLUMN FK_PVDID_N INTEGER NOT NULL DEFAULT 0, 
	iadReferringProvider_pvdID FOR COLUMN FK_PVDID_F INTEGER NOT NULL DEFAULT 0, 
	iadInjuryDate FOR COLUMN INJURYDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iadAuthTreatNumber FOR COLUMN AUTHTREATN CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	iadInvoiceType_intID FOR COLUMN FK_INTID INTEGER NOT NULL DEFAULT 0, 
	iadStatus_stsID FOR COLUMN FK_STSID INTEGER NOT NULL DEFAULT 0, 
	iadSPMessage_slpID FOR COLUMN FK_SLPID INTEGER NOT NULL DEFAULT 0, 
	iadModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iadModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	iadActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbInvoiceAncDetail PRIMARY KEY( iadID )
);

/* Setting label text for tbInvoiceAncDetail */
LABEL ON TABLE MDATA.INVANCDETL IS 'tbInvoiceAncDetail' ;

/* Setting table (Long) name for tbInvoiceAncDetail (INVANCDETL) */
RENAME TABLE MDATA.INVANCDETL TO tbInvoiceAncDetail FOR SYSTEM NAME INVANCDETL;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInvoiceAncDetail)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ochID ) AS PK FROM MDATA.tbInvoiceBilledHistory ;

DROP TABLE MDATA.tbInvoiceBilledHistory ;
---------------------------------------------------------------------------
-- tbInvoiceBilledHistory 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INVBILHIST --tbInvoiceBilledHistory 
( 
	ochID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ochInvoice_iadID FOR COLUMN FK_IADID INTEGER NOT NULL DEFAULT 0, 
	ochInsurance_pciID FOR COLUMN FK_PCIID INTEGER NOT NULL DEFAULT 0, 
	ochInvoiceDate FOR COLUMN INVDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ochSPMessage_slpID FOR COLUMN FK_SLPID INTEGER NOT NULL DEFAULT 0, 
	ochInvoiceType_intID FOR COLUMN FK_INTID INTEGER NOT NULL DEFAULT 0, 
	ochModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ochModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ochActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbInvoiceBilledHistory PRIMARY KEY( ochID )
);

/* Setting label text for tbInvoiceBilledHistory */
LABEL ON TABLE MDATA.INVBILHIST IS 'tbInvoiceBilledHistory' ;

/* Setting table (Long) name for tbInvoiceBilledHistory (INVBILHIST) */
RENAME TABLE MDATA.INVBILHIST TO tbInvoiceBilledHistory FOR SYSTEM NAME INVBILHIST;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInvoiceBilledHistory)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(iphID ) AS PK FROM MDATA.tbInvoiceHistory ;

DROP TABLE MDATA.tbInvoiceHistory ;
---------------------------------------------------------------------------
-- tbInvoiceHistory 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INVHIST --tbInvoiceHistory 
( 
	iphID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	iphServiceLine_sidID FOR COLUMN FK_SIDID INTEGER NOT NULL DEFAULT 0, 
	iphPayor_pciID FOR COLUMN FK_PCIID INTEGER NOT NULL DEFAULT 0, 
	iphAmount FOR COLUMN INVAMOUNT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	iphTransCode_trcID FOR COLUMN FK_TRCID INTEGER NOT NULL DEFAULT 0, 
	iphTransDate FOR COLUMN TRANSDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iphDepositID_ddfID FOR COLUMN FK_DDFID INTEGER NOT NULL DEFAULT 0, 
	iphMonthEnd FOR COLUMN MONTHEND CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	iphModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iphModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	iphActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbInvoiceHistory PRIMARY KEY( iphID )
);

/* Setting label text for tbInvoiceHistory */
LABEL ON TABLE MDATA.INVHIST IS 'tbInvoiceHistory' ;

/* Setting table (Long) name for tbInvoiceHistory (INVHIST) */
RENAME TABLE MDATA.INVHIST TO tbInvoiceHistory FOR SYSTEM NAME INVHIST;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInvoiceHistory)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(iinID ) AS PK FROM MDATA.tbInvoiceInsurance ;

DROP TABLE MDATA.tbInvoiceInsurance ;
---------------------------------------------------------------------------
-- tbInvoiceInsurance 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INVINS --tbInvoiceInsurance 
( 
	iinID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 2 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	iinInvoice_iadID FOR COLUMN FK_IADID INTEGER NOT NULL DEFAULT 0, 
	iinPatientInsurance_ptiID FOR COLUMN FK_PTIID INTEGER NOT NULL DEFAULT 0, 
	iinOrdinal FOR COLUMN ORDINL INTEGER NOT NULL DEFAULT 0, 
	iinModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	iinModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	iinActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbInvoiceInsurance PRIMARY KEY( iinID )
);

/* Setting label text for tbInvoiceInsurance */
LABEL ON TABLE MDATA.INVINS IS 'tbInvoiceInsurance' ;

/* Setting table (Long) name for tbInvoiceInsurance (INVINS) */
RENAME TABLE MDATA.INVINS TO tbInvoiceInsurance FOR SYSTEM NAME INVINS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInvoiceInsurance)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(intID ) AS PK FROM MDATA.tbInvoiceType ;

DROP TABLE MDATA.tbInvoiceType ;
---------------------------------------------------------------------------
-- tbInvoiceType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.INVTYPE --tbInvoiceType 
( 
	intID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	intCode FOR COLUMN INVTYPCODE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	intDescription FOR COLUMN DESCR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	intModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	intModifiedBy_usr FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	intActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbInvoiceType PRIMARY KEY( intID )
);

/* Setting label text for tbInvoiceType */
LABEL ON TABLE MDATA.INVTYPE IS 'tbInvoiceType' ;

/* Setting table (Long) name for tbInvoiceType (INVTYPE) */
RENAME TABLE MDATA.INVTYPE TO tbInvoiceType FOR SYSTEM NAME INVTYPE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbInvoiceType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(mtfID ) AS PK FROM MDATA.tbMiscTran ;

DROP TABLE MDATA.MiscTran ;
---------------------------------------------------------------------------
-- tbMiscTran 
---------------------------------------------------------------------------
CREATE TABLE MDATA.MISCTRAN --tbMiscTran 
( 
	mtfID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	mtfDepositID_ddfID FOR COLUMN FK_DDFID INTEGER NOT NULL DEFAULT 0, 
	mtfCheckNumber FOR COLUMN CHKNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	mtfCheckDate FOR COLUMN CHECKDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	mtfCheckAmount FOR COLUMN CHKAMT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	mtfPayor FOR COLUMN PAYOR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	mtfGuarantor FOR COLUMN GUARANTOR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	mtfTransaction_trcID FOR COLUMN FK_TRCID INTEGER NOT NULL DEFAULT 0, 
	mtfModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	mtfModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	mtfActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbMiscTran PRIMARY KEY( mtfID )
);

/* Setting label text for tbMiscTran */
LABEL ON TABLE MDATA.MISCTRAN IS 'tbMiscTran' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbMiscTran FOR MDATA.MISCTRAN;

--start journaling this table
--EXEC STRJRNPF  FILE(tbMiscTran)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pciID ) AS PK FROM MDATA.tbPatientClaimInsurance ;

DROP TABLE MDATA.tbPatientClaimInsurance ;
---------------------------------------------------------------------------
-- tbPatientClaimInsurance 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PATCLAIMIN --tbPatientClaimInsurance 
( 
	pciID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 2 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pciInvoiceID_iadID FOR COLUMN FK_IADID INTEGER NOT NULL DEFAULT 0, 
	pciPatientInsurance_ptiID FOR COLUMN FK_PTIID INTEGER NOT NULL DEFAULT 0, 
	pciOrdinal FOR COLUMN ORDINL INTEGER NOT NULL DEFAULT 0, 
	pciModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pciModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pciActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbPatientClaimInsurance PRIMARY KEY( pciID )
);

/* Setting label text for tbPatientClaimInsurance */
LABEL ON TABLE MDATA.PATCLAIMIN IS 'tbPatientClaimInsurance' ;

/* Setting table (Long) name for tbPatientClaimInsurance (PATCLAIMIN) */
RENAME TABLE MDATA.PATCLAIMIN TO tbPatientClaimInsurance FOR SYSTEM NAME PATCLAIMIN;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPatientClaimInsurance)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pdeID ) AS PK FROM MDATA.tbPatientDemographicErrors ;

DROP TABLE MDATA.tbPatientDemographicErrors ;
---------------------------------------------------------------------------
-- tbPatientDemographicErrors 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PATDEMOGER --tbPatientDemographicErrors 
( 
	pdeID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pdePatValidate_pacID FOR COLUMN FK_PACID INTEGER NOT NULL DEFAULT 0, 
	pdeFieldName FOR COLUMN FIELDNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pdeErrorMessage FOR COLUMN ERRORMSG CHAR(255) CCSID 37 NOT NULL DEFAULT ' ',
	pdeModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pdeModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pdeActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbPatientDemographicErrors PRIMARY KEY( pdeID )
);

/* Setting label text for tbPatientDemographicErrors */
LABEL ON TABLE MDATA.PATDEMOGER IS 'tbPatientDemographicErrors' ;

/* Setting table (Long) name for tbPatientDemographicErrors (PATDEMOGER) */
RENAME TABLE MDATA.PATDEMOGER TO tbPatientDemographicErrors FOR SYSTEM NAME PATDEMOGER;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPatientDemographicErrors)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(patID ) AS PK FROM MDATA.tbPatientDemographics ;

drop table MDATA.tbpatientdemographics; commit;
---------------------------------------------------------------------------
-- tbPatientDemographics 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PATNDEMOG --tbPatientDemographics 
( 
	patID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 7219 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	patClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	patLastName FOR COLUMN LASTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patFirstName FOR COLUMN FIRSTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patAddress FOR COLUMN PDADDRESS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patCity FOR COLUMN PDCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	patState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	patZipcode FOR COLUMN PDZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	patAcceptAddress FOR COLUMN ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	patDOB FOR COLUMN DOB CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	patGender FOR COLUMN GENDER CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	patSSN FOR COLUMN SSN CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	patEmancipated FOR COLUMN EMANCIPATD CHAR(1) NOT NULL DEFAULT ' ', 
	patGuarRelationship_relID FOR COLUMN FK_RELID INTEGER NOT NULL DEFAULT 0, 
	patGuarLastName FOR COLUMN GUARLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patGuarFirstName FOR COLUMN GUARFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patGuarAddress FOR COLUMN GUARADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patGuarCity FOR COLUMN GUARCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	patGuarState_staID FOR COLUMN FK_STAID_G INTEGER NOT NULL DEFAULT 0, 
	patGuarZipcode FOR COLUMN GUARZIP CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	patGuarAcceptAddress FOR COLUMN GUARADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	patPhone FOR COLUMN PHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	patModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	patModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	patErrorMessage FOR COLUMN ERRORMSG CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	patActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbPatientDemographics PRIMARY KEY( patID )
);

/* Setting label text for tbPatientDemographics */
LABEL ON TABLE MDATA.PATNDEMOG IS 'tbPatientDemographics' ;

/* Setting table (Long) name for tbPatientDemographics (PATNDEMOG) */
RENAME TABLE MDATA.PATNDEMOG TO tbPatientDemographics FOR SYSTEM NAME PATNDEMOG;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPatientDemographics)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pacID ) AS PK FROM MDATA.tbPatientDemographicValidation ;

drop table MDATA.tbPatientDemographicValidation; commit;
---------------------------------------------------------------------------
-- tbPatientDemographicValidation 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PATDEMOGVL --tbPatientDemographicValidation 
( 
	pacID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 2 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pacPatient_patID FOR COLUMN FK_PATID INTEGER NOT NULL DEFAULT 0, 
	pacRegistry_regID FOR COLUMN FK_REGID INTEGER NOT NULL DEFAULT 0, 
	pacNewLastName FOR COLUMN NEWLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewFirstName FOR COLUMN NEWFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewSex FOR COLUMN NEWSEX CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewDateOfBirth FOR COLUMN NEWDOB CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pacNewAddress FOR COLUMN NEWADDRESS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewCity FOR COLUMN NEWCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewState_staID FOR COLUMN FK_STAID_N INTEGER NOT NULL DEFAULT 0, 
	pacNewZipCode FOR COLUMN NEWZIPCODE CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	pacAcceptAddress FOR COLUMN ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	pacPatientAddressNotValid FOR COLUMN PATADRBAD CHAR(1) NOT NULL DEFAULT ' ', 
	pacAddressCheckErrMessage FOR COLUMN ADRERRMSG CHAR(255) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewTelephone FOR COLUMN NEWPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewSocialSecurityNumber FOR COLUMN NEWSSN CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewMedicaidNumber FOR COLUMN NEWMANUM CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	pacNewMedicareNumber FOR COLUMN NEWMCNUM CHAR(15) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarRelationship_relID FOR COLUMN FK_RELID INTEGER NOT NULL DEFAULT 0, 
	pacGuarLastName FOR COLUMN GUARLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarFirstName FOR COLUMN GUARFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarAddress FOR COLUMN GUARADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarCity FOR COLUMN GUARCITY CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarState_staID FOR COLUMN FK_STAID_G INTEGER NOT NULL DEFAULT 0, 
	pacGuarZipcode FOR COLUMN GUARZIP CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarAcceptAddress FOR COLUMN GUARADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarantorAddressNotValid FOR COLUMN GUARADRBAD CHAR(1) NOT NULL DEFAULT ' ', 
	pacGuarantorAddressCheckErrMessage FOR COLUMN GUARADRERR CHAR(255) CCSID 37 NOT NULL DEFAULT ' ',
	pacGuarPhone FOR COLUMN GUARPHONE CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	pacModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pacModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pacActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbPatientDemographicValidation PRIMARY KEY( pacID )
);

/* Setting label text for tbPatientDemographicValidation */
LABEL ON TABLE MDATA.PATDEMOGVL IS 'tbPatientDemographicValidation' ;

/* Setting table (Long) name for tbPatientDemographicValidation (PATDEMOGVL) */
RENAME TABLE MDATA.PATDEMOGVL TO tbPatientDemographicValidation FOR SYSTEM NAME PATDEMOGVL;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPatientDemographicValidation)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ptiID ) AS PK FROM MDATA.tbPatientInsurance ;

DROP TABLE MDATA.tbPatientInsurance ;
---------------------------------------------------------------------------
-- tbPatientInsurance 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PATIENTINS --tbPatientInsurance 
( 
	ptiID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 2 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ptiPatient_patID FOR COLUMN FK_PATID INTEGER NOT NULL DEFAULT 0, 
	ptiSubscriberLastName FOR COLUMN SUBSCLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ptiSubscriberFirstName FOR COLUMN SUBSCFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ptiSubscriberGender FOR COLUMN SUBSCGENDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ptiSubscriberEmployer FOR COLUMN SUBSCEMP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ptiSubscriberRelationship_relID FOR COLUMN FK_RELID INTEGER NOT NULL DEFAULT 0, 
	ptiInsuranceID_insID FOR COLUMN FK_INSID INTEGER NOT NULL DEFAULT 0, 
	ptiContractNumber FOR COLUMN CONTRNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ptiGroupNumber FOR COLUMN GROUPNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	ptiEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ptiModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ptiModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ptiActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbPatientInsurance PRIMARY KEY( ptiID )
);

/* Setting label text for tbPatientInsurance */
LABEL ON TABLE MDATA.PATIENTINS IS 'tbPatientInsurance' ;

/* Setting table (Long) name for tbPatientInsurance (PATIENTINS) */
RENAME TABLE MDATA.PATIENTINS TO tbPatientInsurance FOR SYSTEM NAME PATIENTINS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPatientInsurance)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(prtID ) AS PK FROM MDATA.tbPermissions ;

DROP TABLE MDATA.tbPermissions ;
---------------------------------------------------------------------------
-- tbPermissions 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PERMISSNS --tbPermissions 
( 
	prtID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 5 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	prtName FOR COLUMN PERMISNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	prtModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	prtModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	prtActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbPermissions PRIMARY KEY( prtID )
);

/* Setting label text for tbPermissions */
LABEL ON TABLE MDATA.PERMISSNS IS 'tbPermissions' ;

/* Setting table (Long) name for tbPermissions (PERMISSNS) */
RENAME TABLE MDATA.PERMISSNS TO tbPermissions FOR SYSTEM NAME PERMISSNS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPermissions)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(posID ) AS PK FROM MDATA.tbPlaceOfService ;

DROP TABLE MDATA.tbPlaceOfService ;
---------------------------------------------------------------------------
-- tbPlaceOfService 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PLACEOFSVC --tbPlaceOfService 
( 
	posID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 14 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	posCode FOR COLUMN POSCOD CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	posDescription FOR COLUMN POSDESCR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	posModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	posModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	posActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	posBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	posEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbPlaceOfService PRIMARY KEY( posID )
);

/* Setting label text for tbPlaceOfService */
LABEL ON TABLE MDATA.PLACEOFSVC IS 'tbPlaceOfService' ;

/* Setting table (Long) name for tbPlaceOfService (PLACEOFSVC) */
RENAME TABLE MDATA.PLACEOFSVC TO tbPlaceOfService FOR SYSTEM NAME PLACEOFSVC;

--start journaling this table
--EXEC STRJRNPF  FILE(tbPlaceOfService)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pctID ) AS PK FROM MDATA.tbProcedureClassClientType ;

DROP TABLE MDATA.tbProcedureClassClientType ;
---------------------------------------------------------------------------
-- tbProcedureClassClientType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRCCLSCLIT --tbProcedureClassClientType 
( 
	pctID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 14 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pctProcedureClass_pclID FOR COLUMN FK_PCLID INTEGER NOT NULL DEFAULT 0, 
	pctClientType_ctyID FOR COLUMN FK_CTYID INTEGER NOT NULL DEFAULT 0, 
	pctModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pctModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pctActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProcedureClassClientType PRIMARY KEY( pctID )
);

/* Setting label text for tbProcedureClassClientType */
LABEL ON TABLE MDATA.PRCCLSCLIT IS 'tbProcedureClassClientType' ;

/* Setting table (Long) name for tbProcedureClassClientType (PRCCLSCLIT) */
RENAME TABLE MDATA.PRCCLSCLIT TO tbProcedureClassClientType FOR SYSTEM NAME PRCCLSCLIT;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureClassClientType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(rxcID ) AS PK FROM MDATA.tbProcedureCode ;

DROP TABLE MDATA.tbProcedureCode ;
---------------------------------------------------------------------------
-- tbProcedureCode 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PROCCODE --tbProcedureCode 
( 
	rxcID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1015 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	rxcCode FOR COLUMN PROCCODE CHAR(5) CCSID 37 NOT NULL DEFAULT ' ',
	rxcDescription FOR COLUMN PROCDESCR CHAR(240) CCSID 37 NOT NULL DEFAULT ' ',
	rxcEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	rxcClassification_pclID FOR COLUMN FK_PCLID INTEGER NOT NULL DEFAULT 0, 
	rxcRelativeValueUnit FOR COLUMN RELVALUNIT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	rxcBillableCode FOR COLUMN BILLABLECD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcStudentResponse FOR COLUMN STURESP CHAR(1) NOT NULL DEFAULT ' ', 
	rxcTimesRequired FOR COLUMN TIMESREQD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcMinimumMinutes FOR COLUMN MINMINUTES INTEGER NOT NULL DEFAULT 0, 
	rxcPrescriptionRequired FOR COLUMN RXREQD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcReferralRequired FOR COLUMN REFREQD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcIdeaCode FOR COLUMN IDEACODE CHAR(1) NOT NULL DEFAULT ' ', 
	rxcIepCode FOR COLUMN IEPCODE CHAR(1) NOT NULL DEFAULT ' ', 
	rxcSBHSTransportation FOR COLUMN SBHSTPORT CHAR(1) NOT NULL DEFAULT ' ', 
	rxcSBHSIndividualGroup FOR COLUMN SBHSINDGRP CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	rxcRootCode FOR COLUMN ROOTCODE CHAR(1) NOT NULL DEFAULT ' ', 
	rxcAddOnCode FOR COLUMN ADDONCODE CHAR(1) NOT NULL DEFAULT ' ', 
	rxcQuantityRequired FOR COLUMN QTYREQD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcProcedureOnly FOR COLUMN PROCONLY CHAR(1) NOT NULL DEFAULT ' ', 
	rxcConsultCode FOR COLUMN CONSULTCD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcObservation FOR COLUMN OBSERVATN CHAR(1) NOT NULL DEFAULT ' ', 
	rxcAnesthesia FOR COLUMN ANESTHESIA CHAR(1) NOT NULL DEFAULT ' ', 
	rxcInpatient FOR COLUMN INPATIENT CHAR(1) NOT NULL DEFAULT ' ', 
	rxcCriticalCareCode FOR COLUMN CRITCARECD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcInjuryCode FOR COLUMN INJURYCODE CHAR(1) NOT NULL DEFAULT ' ', 
	rxcNeedsModifier FOR COLUMN NEEDSMOD CHAR(1) NOT NULL DEFAULT ' ', 
	rxcType_pctID FOR COLUMN FK_PCTID INTEGER NOT NULL DEFAULT 0, 
	rxcSBHSTransportationAllowed FOR COLUMN SBTRNALLOW CHAR(1) NOT NULL DEFAULT ' ', 
	rxcSBHSCodeFrequencyDayRange FOR COLUMN SBCDFRQDRN CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rxcSBHSCodeFrequencyNumber FOR COLUMN SBCDFREQNO CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rxcSBHSCodeQuantityPerDay FOR COLUMN SBCDQTPRDY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rxcSBHSQtyDayProvider FOR COLUMN SBQTYDYPRV CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rxcSBHSDirectIntervention FOR COLUMN SBDIRINTRV CHAR(1) NOT NULL DEFAULT ' ', 
	rxcSBHSUnitDescription FOR COLUMN SBUNITDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rxcSBHSCode FOR COLUMN SBHSCODE CHAR(1) NOT NULL DEFAULT ' ', 
	rxcModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	rxcModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	rxcActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProcedureCode PRIMARY KEY( rxcID )
);

/* Setting label text for tbProcedureCode */
LABEL ON TABLE MDATA.PROCCODE IS 'tbProcedureCode' ;

/* Setting table (Long) name for tbProcedureCode (PROCCODE) */
RENAME TABLE MDATA.PROCCODE TO tbProcedureCode FOR SYSTEM NAME PROCCODE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureCode)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pclID ) AS PK FROM MDATA.tbProcedureCodeClassification ;

DROP TABLE MDATA.tbProcedureCodeClassification ;
---------------------------------------------------------------------------
-- tbProcedureCodeClassification 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRCCDCLASS --tbProcedureCodeClassification 
( 
	pclID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 77 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pclAbbr FOR COLUMN ABBR CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	pclDescription FOR COLUMN DESCRIP CHAR(240) CCSID 37 NOT NULL DEFAULT ' ',
	pclModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pclModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pclActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	pclBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pclEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbProcedureCodeClassification PRIMARY KEY( pclID )
);

/* Setting label text for tbProcedureCodeClassification */
LABEL ON TABLE MDATA.PRCCDCLASS IS 'tbProcedureCodeClassification' ;

/* Setting table (Long) name for tbProcedureCodeClassification (PRCCDCLASS) */
RENAME TABLE MDATA.PRCCDCLASS TO tbProcedureCodeClassification FOR SYSTEM NAME PRCCDCLASS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureCodeClassification)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pctID ) AS PK FROM MDATA.tbProcedureCodeClientType ;

DROP TABLE MDATA.tbProcedureCodeClientType ;
---------------------------------------------------------------------------
-- tbProcedureCodeClientType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRCCDCLTYP --tbProcedureCodeClientType 
( 
	pctID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 991 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pctProcedureCode_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	pctClientType_ctyID FOR COLUMN FK_CTYID INTEGER NOT NULL DEFAULT 0, 
	pctModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pctModifiedBy_UsrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pctActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProcedureCodeClientType PRIMARY KEY( pctID )
);

/* Setting label text for tbProcedureCodeClientType */
LABEL ON TABLE MDATA.PRCCDCLTYP IS 'tbProcedureCodeClientType' ;

/* Setting table (Long) name for tbProcedureCodeClientType (PRCCDCLTYP) */
RENAME TABLE MDATA.PRCCDCLTYP TO tbProcedureCodeClientType FOR SYSTEM NAME PRCCDCLTYP;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureCodeClientType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(limID ) AS PK FROM MDATA.tbProcedureCodeStateBillLimitations ;

DROP TABLE MDATA.tbProcedureCodeStateBillLimitations ;
---------------------------------------------------------------------------
-- tbProcedureCodeStateBillLimitations 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRCCDSTLMT --tbProcedureCodeStateBillLimitations 
( 
	limID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 54 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	limProcedureCode_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	limState_staid FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	limSBHSCodeFrequencyDayRange FOR COLUMN SBCDFQDYRG CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	limSBHSCodeFrequencyNumber FOR COLUMN SBCDFREQNO CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	limSBHSCodeQuantityPerDay FOR COLUMN SBCDQPERDY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	limSBHSQtyDayProvider FOR COLUMN SBQTYDYPRV CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	limModifiedDate FOR COLUMN MODIFIEDDT CHAR(8) CCSID 37 NOT NULL DEFAULT ' ',
	limModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	limActive FOR COLUMN ACTIVE INTEGER NOT NULL DEFAULT 0, 
	CONSTRAINT MDATA.PK_tbProcedureCodeStateBillLimitations PRIMARY KEY( limID )
);

/* Setting label text for tbProcedureCodeStateBillLimitations */
LABEL ON TABLE MDATA.PRCCDSTLMT IS 'tbProcedureCodeStateBillLimitations' ;

/* Setting table (Long) name for tbProcedureCodeStateBillLimitations (PRCCDSTLMT) */
RENAME TABLE MDATA.PRCCDSTLMT TO tbProcedureCodeStateBillLimitations FOR SYSTEM NAME PRCCDSTLMT;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureCodeStateBillLimitations)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pmcID ) AS PK FROM MDATA.tbProcedureModifierCode ;

DROP TABLE MDATA.tbProcedureModifierCode ;
---------------------------------------------------------------------------
-- tbProcedureModifierCode 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PROCMODCOD --tbProcedureModifierCode 
( 
	pmcID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 20 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pmcCode FOR COLUMN PRMODCODE CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	pmcDescription FOR COLUMN PRMODDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pmcSBHSCode FOR COLUMN SBHSCODE CHAR(1) NOT NULL DEFAULT ' ', 
	pmcModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pmcModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pmcActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	pmcBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pmcEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbProcedureModifierCode PRIMARY KEY( pmcID )
);

/* Setting label text for tbProcedureModifierCode */
LABEL ON TABLE MDATA.PROCMODCOD IS 'tbProcedureModifierCode' ;

/* Setting table (Long) name for tbProcedureModifierCode (PROCMODCOD) */
RENAME TABLE MDATA.PROCMODCOD TO tbProcedureModifierCode FOR SYSTEM NAME PROCMODCOD;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureModifierCode)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pumID ) AS PK FROM MDATA.tbProcedureUsedModifiers ;

DROP TABLE MDATA.tbProcedureUsedModifiers ;
---------------------------------------------------------------------------
-- tbProcedureUsedModifiers 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PROCUSEMOD --tbProcedureUsedModifiers 
( 
	pumID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pumProcedure_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	pumModifier_pmcID FOR COLUMN FK_PMCID INTEGER NOT NULL DEFAULT 0, 
	pumModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pumModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pumActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProcedureUsedModifiers PRIMARY KEY( pumID )
);

/* Setting label text for tbProcedureUsedModifiers */
LABEL ON TABLE MDATA.PROCUSEMOD IS 'tbProcedureUsedModifiers' ;

/* Setting table (Long) name for tbProcedureUsedModifiers (PROCUSEMOD) */
RENAME TABLE MDATA.PROCUSEMOD TO tbProcedureUsedModifiers FOR SYSTEM NAME PROCUSEMOD;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcedureUsedModifiers)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(prcID ) AS PK FROM MDATA.tbProcess ;

DROP TABLE MDATA.Process ;
---------------------------------------------------------------------------
-- tbProcess 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PROCESS --tbProcess 
( 
	prcID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	prcName FOR COLUMN PROCNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	prcDescription FOR COLUMN PROCDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	prcIsFileType FOR COLUMN ISFILETYPE CHAR(1) NOT NULL DEFAULT ' ', 
	prcModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	prcModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	prcActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProcess PRIMARY KEY( prcID )
);

/* Setting label text for tbProcess */
LABEL ON TABLE MDATA.PROCESS IS 'tbProcess' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbProcess FOR MDATA.PROCESS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProcess)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(plgID ) AS PK FROM MDATA.tbProductionLog ;

DROP TABLE MDATA.tbProductionLog ;
---------------------------------------------------------------------------
-- tbProductionLog 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRODLOG --tbProductionLog 
( 
	plgID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 11 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	plgClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	plgDateOfService FOR COLUMN DATEOFSVC CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	plgDistributionDateReceived FOR COLUMN DISTDTRCVD CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	plgDistributionReceivedBy_usrID FOR COLUMN FK_USRID_R INTEGER NOT NULL DEFAULT 0, 
	plgDistributionDateCompleted FOR COLUMN DISTDTCOMP CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	plgDistributionCompletedBy_usrID FOR COLUMN FK_USRID_C INTEGER NOT NULL DEFAULT 0, 
	plgSourceCodingDateCompleted FOR COLUMN SRCCDDTCMP CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	plgSourceCodingCompletedBy_usrID FOR COLUMN FK_USRID_S INTEGER NOT NULL DEFAULT 0, 
	plgMedicalCodingDateCompleted FOR COLUMN MEDCDDTCMP CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	plgMedicalCodingCompletedBy_usrID FOR COLUMN FK_USRID_M INTEGER NOT NULL DEFAULT 0, 
	plgNoRegistryReceived FOR COLUMN NOREGRCVD CHAR(1) NOT NULL DEFAULT ' ', 
	plgModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	plgModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	plgActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProductionLog PRIMARY KEY( plgID )
);

/* Setting label text for tbProductionLog */
LABEL ON TABLE MDATA.PRODLOG IS 'tbProductionLog' ;

/* Setting table (Long) name for tbProductionLog (PRODLOG) */
RENAME TABLE MDATA.PRODLOG TO tbProductionLog FOR SYSTEM NAME PRODLOG;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProductionLog)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pinID ) AS PK FROM MDATA.tbProviderInsuranceNumber ;

DROP TABLE MDATA.tbProviderInsuranceNumber ;
---------------------------------------------------------------------------
-- tbProviderInsuranceNumber 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRVINSNUM --tbProviderInsuranceNumber 
( 
	pinID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 879 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pinProviderID_pvdID FOR COLUMN FK_PVDID INTEGER NOT NULL DEFAULT 0, 
	pinInsuranceID_insID FOR COLUMN FK_INSID INTEGER NOT NULL DEFAULT 0, 
	pinProviderNumber FOR COLUMN PRVNUM CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	pinBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pinEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pinModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pinModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pinActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProviderInsuranceNumber PRIMARY KEY( pinID )
);

/* Setting label text for tbProviderInsuranceNumber */
LABEL ON TABLE MDATA.PRVINSNUM IS 'tbProviderInsuranceNumber' ;

/* Setting table (Long) name for tbProviderInsuranceNumber (PRVINSNUM) */
RENAME TABLE MDATA.PRVINSNUM TO tbProviderInsuranceNumber FOR SYSTEM NAME PRVINSNUM;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProviderInsuranceNumber)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pvsID ) AS PK FROM MDATA.tbProviderStatus ;

DROP TABLE MDATA.tbProviderStatus ;
---------------------------------------------------------------------------
-- tbProviderStatus 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRVSTATUS --tbProviderStatus 
( 
	pvsID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 28 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pvsCode FOR COLUMN PRVSTCODE CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	pvsDescription FOR COLUMN PRVSTDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvsClientType_ctyID FOR COLUMN FK_CTYID INTEGER NOT NULL DEFAULT 0, 
	pvsModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pvsModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pvsActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProviderStatus PRIMARY KEY( pvsID )
);

/* Setting label text for tbProviderStatus */
LABEL ON TABLE MDATA.PRVSTATUS IS 'tbProviderStatus' ;

/* Setting table (Long) name for tbProviderStatus (PRVSTATUS) */
RENAME TABLE MDATA.PRVSTATUS TO tbProviderStatus FOR SYSTEM NAME PRVSTATUS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProviderStatus)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(pvtID ) AS PK FROM MDATA.tbProviderType ;

DROP TABLE MDATA.tbProviderType ;
---------------------------------------------------------------------------
-- tbProviderType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRVTYPE --tbProviderType 
( 
	pvtID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 181 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	pvtClientType_ctyID FOR COLUMN FK_CTYID INTEGER NOT NULL DEFAULT 0, 
	pvtDescription FOR COLUMN PRVTPDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvtTypeCode FOR COLUMN TYPECODE CHAR(5) CCSID 37 NOT NULL DEFAULT ' ',
	pvtX12TypeCode FOR COLUMN X12TYPCD CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvtTypeGroupCode FOR COLUMN TYPGRPCD CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	pvtTypeGroupDescription FOR COLUMN TYPGRPDESC CHAR(100) CCSID 37 NOT NULL DEFAULT ' ',
	pvtIndiana FOR COLUMN INDIANA CHAR(1) NOT NULL DEFAULT ' ', 
	pvtMichigan FOR COLUMN MICHIGAN CHAR(1) NOT NULL DEFAULT ' ', 
	pvtOrderedServices FOR COLUMN ORDSVCS CHAR(1) NOT NULL DEFAULT ' ', 
	pvtProgressSummary FOR COLUMN PROGSUM CHAR(1) NOT NULL DEFAULT ' ', 
	pvtPrimaryProvider FOR COLUMN PRIMARYPRV CHAR(1) NOT NULL DEFAULT ' ', 
	pvtModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	pvtModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	pvtActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProviderType PRIMARY KEY( pvtID )
);

/* Setting label text for tbProviderType */
LABEL ON TABLE MDATA.PRVTYPE IS 'tbProviderType' ;

/* Setting table (Long) name for tbProviderType (PRVTYPE) */
RENAME TABLE MDATA.PRVTYPE TO tbProviderType FOR SYSTEM NAME PRVTYPE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProviderType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(ptpID ) AS PK FROM MDATA.tbProviderTypeProcedureTable ;

DROP TABLE MDATA.tbProviderTypeProcedureTable ;
---------------------------------------------------------------------------
-- tbProviderTypeProcedureTable 
---------------------------------------------------------------------------
CREATE TABLE MDATA.PRVTYPPROC --tbProviderTypeProcedureTable 
( 
	ptpID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 351 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	ptpProviderType_pvtID FOR COLUMN FK_PVTID INTEGER NOT NULL DEFAULT 0, 
	ptpProcedure_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	ptpModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	ptpModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	ptpActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbProviderTypeProcedureTable PRIMARY KEY( ptpID )
);

/* Setting label text for tbProviderTypeProcedureTable */
LABEL ON TABLE MDATA.PRVTYPPROC IS 'tbProviderTypeProcedureTable' ;

/* Setting table (Long) name for tbProviderTypeProcedureTable (PRVTYPPROC) */
RENAME TABLE MDATA.PRVTYPPROC TO tbProviderTypeProcedureTable FOR SYSTEM NAME PRVTYPPROC;

--start journaling this table
--EXEC STRJRNPF  FILE(tbProviderTypeProcedureTable)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(regID ) AS PK FROM MDATA.tbRegistryLog ;

DROP TABLE MDATA.tbRegistryLog ;
---------------------------------------------------------------------------
-- tbRegistryLog 
---------------------------------------------------------------------------
CREATE TABLE MDATA.REGLOG --tbRegistryLog 
( 
	regID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 4468 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	regClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	regEncounterNumber FOR COLUMN ENCNUM CHAR(17) CCSID 37 NOT NULL DEFAULT ' ',
	regInvoiceAncID_iadID FOR COLUMN FK_IADID INTEGER NOT NULL DEFAULT 0, 
	regPatient_patID FOR COLUMN FK_PATID INTEGER NOT NULL DEFAULT 0, 
	regClaimHolding_clhID FOR COLUMN FK_CLHID INTEGER NOT NULL DEFAULT 0, 
	regStandardRegistry_cvrID FOR COLUMN FK_CVRID INTEGER NOT NULL DEFAULT 0, 
	regStandardRegistry_cvrDOS FOR COLUMN STDREGDOS CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	regStatus_rgsID FOR COLUMN FK_RGSID INTEGER NOT NULL DEFAULT 0, 
	regEnteredElectronically FOR COLUMN ELECTRONCL CHAR(1) NOT NULL DEFAULT ' ', 
	regImportFileName FOR COLUMN IMPFILENAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	regModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	regModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	regActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbRegistryLog PRIMARY KEY( regID )
);

/* Setting label text for tbRegistryLog */
LABEL ON TABLE MDATA.REGLOG IS 'tbRegistryLog' ;

/* Setting table (Long) name for tbRegistryLog (REGLOG) */
RENAME TABLE MDATA.REGLOG TO tbRegistryLog FOR SYSTEM NAME REGLOG;

--start journaling this table
--EXEC STRJRNPF  FILE(tbRegistryLog)  JRN(MIPSTIM/JRNLDEFAULT)
--GO




--SELECT MAX(rgsID ) AS PK FROM MDATA.tbRegistryStatus ;

drop table MDATA.tbRegistryStatus; commit;
---------------------------------------------------------------------------
-- tbRegistryStatus 
---------------------------------------------------------------------------
CREATE TABLE MDATA.REGSTATUS --tbRegistryStatus 
( 
	rgsID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 38 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	rgsStatus  CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	rgsDescription FOR COLUMN RGSTATDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rgsModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	rgsModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	rgsActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	rgsBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	rgsEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbRegistryStatus PRIMARY KEY( rgsID )
);

/* Setting label text for tbRegistryStatus */
LABEL ON TABLE MDATA.REGSTATUS IS 'tbRegistryStatus' ;

/* Setting table (Long) name for tbRegistryStatus (REGSTATUS) */
RENAME TABLE MDATA.REGSTATUS TO tbRegistryStatus FOR SYSTEM NAME REGSTATUS;

--start journaling this table
--EXEC STRJRNPF  FILE(tbRegistryStatus)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(relID ) AS PK FROM MDATA.tbRelationships ;

DROP TABLE MDATA.tbRelationships ;
---------------------------------------------------------------------------
-- tbRelationships 
---------------------------------------------------------------------------
CREATE TABLE MDATA.RELATNSHP --tbRelationships 
( 
	relID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 8 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	relCode CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	relDescription FOR COLUMN RELDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	relModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	relModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	relActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	relBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	relEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbRelationships PRIMARY KEY( relID )
);

/* Setting label text for tbRelationships */
LABEL ON TABLE MDATA.RELATNSHP IS 'tbRelationships' ;

/* Setting table (Long) name for tbRelationships (RELATNSHP) */
RENAME TABLE MDATA.RELATNSHP TO tbRelationships FOR SYSTEM NAME RELATNSHP;

--start journaling this table
--EXEC STRJRNPF  FILE(tbRelationships)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(spcID ) AS PK FROM MDATA.tbSchoolProcedureCodeState ;

DROP TABLE MDATA.tbSchoolProcedureCodeState ;
---------------------------------------------------------------------------
-- tbSchoolProcedureCodeState 
---------------------------------------------------------------------------
CREATE TABLE MDATA.SCHPRCCDST --tbSchoolProcedureCodeState 
( 
	spcID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 231 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	spcProcedureCode_rxcID FOR COLUMN FK_RXCID INTEGER NOT NULL DEFAULT 0, 
	spcState_staID FOR COLUMN FK_STAID INTEGER NOT NULL DEFAULT 0, 
	spcModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	spcModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	spcActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbSchoolProcedureCodeState PRIMARY KEY( spcID )
);

/* Setting label text for tbSchoolProcedureCodeState */
LABEL ON TABLE MDATA.SCHPRCCDST IS 'tbSchoolProcedureCodeState' ;

/* Setting table (Long) name for tbSchoolProcedureCodeState (SCHPRCCDST) */
RENAME TABLE MDATA.SCHPRCCDST TO tbSchoolProcedureCodeState FOR SYSTEM NAME SCHPRCCDST;

--start journaling this table
--EXEC STRJRNPF  FILE(tbSchoolProcedureCodeState)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(slpID ) AS PK FROM MDATA.tbSelfPayMessage ;

DROP TABLE MDATA.tbSelfPayMessage ;
---------------------------------------------------------------------------
-- tbSelfPayMessage 
---------------------------------------------------------------------------
CREATE TABLE MDATA.SELFPAYMSG --tbSelfPayMessage 
( 
	slpID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 21 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	slpCode FOR COLUMN SLFPAYCODE CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	slpDescription FOR COLUMN SLFPAYDESC CHAR(240) CCSID 37 NOT NULL DEFAULT ' ',
	slpEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	slpModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	slpModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	slpActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	slpBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbSelfPayMessage PRIMARY KEY( slpID )
);

/* Setting label text for tbSelfPayMessage */
LABEL ON TABLE MDATA.SELFPAYMSG IS 'tbSelfPayMessage' ;

/* Setting table (Long) name for tbSelfPayMessage (SELFPAYMSG) */
RENAME TABLE MDATA.SELFPAYMSG TO tbSelfPayMessage FOR SYSTEM NAME SELFPAYMSG;

--start journaling this table
--EXEC STRJRNPF  FILE(tbSelfPayMessage)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(slfID ) AS PK FROM MDATA.tbServiceLineFinancial ;

DROP TABLE MDATA.tbServiceLineFinancial ;
---------------------------------------------------------------------------
-- tbServiceLineFinancial 
---------------------------------------------------------------------------
CREATE TABLE MDATA.SVCLNFIN --tbServiceLineFinancial 
( 
	slfID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 3 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	slfServiceLine_sidID FOR COLUMN FK_SIDID INTEGER NOT NULL DEFAULT 0, 
	slfTransCode_trcID FOR COLUMN FK_TRCID INTEGER NOT NULL DEFAULT 0, 
	slfAmount  DECIMAL(10,2) NOT NULL DEFAULT 0, 
	slfMonthEnd FOR COLUMN MONTHEND INTEGER NOT NULL DEFAULT 0, 
	slfModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	slfInvoiceInsurance_iinID FOR COLUMN FK_IINID INTEGER NOT NULL DEFAULT 0, 
	slfDepositDate FOR COLUMN DEPOSITDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	slfModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	slfActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbServiceLineFinancial PRIMARY KEY( slfID )
);

/* Setting label text for tbServiceLineFinancial */
LABEL ON TABLE MDATA.SVCLNFIN IS 'tbServiceLineFinancial' ;

/* Setting table (Long) name for tbServiceLineFinancial (SVCLNFIN) */
RENAME TABLE MDATA.SVCLNFIN TO tbServiceLineFinancial FOR SYSTEM NAME SVCLNFIN;

--start journaling this table
--EXEC STRJRNPF  FILE(tbServiceLineFinancial)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(slhID ) AS PK FROM MDATA.tbServiceLineHoldingFile ;

DROP TABLE MDATA.tbServiceLineHoldingFile ;
---------------------------------------------------------------------------
-- tbServiceLineHoldingFile 
---------------------------------------------------------------------------
CREATE TABLE MDATA.SVCLNHLDFL --tbServiceLineHoldingFile 
( 
	slhID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	slhClaim_clhID FOR COLUMN FK_CLHID INTEGER NOT NULL DEFAULT 0, 
	slhOrdinal FOR COLUMN SLORDINAL INTEGER NOT NULL DEFAULT 0, 
	slhDX_dicID FOR COLUMN FK_DICID INTEGER NOT NULL DEFAULT 0, 
	slhRX_prcID FOR COLUMN FK_PRCID INTEGER NOT NULL DEFAULT 0, 
	slhMod1_pmcID FOR COLUMN FK_PMCID1 INTEGER NOT NULL DEFAULT 0, 
	slhMod2_pmcID FOR COLUMN FK_PMCID2 INTEGER NOT NULL DEFAULT 0, 
	slhMod3_pmcID FOR COLUMN FK_PMCID3 INTEGER NOT NULL DEFAULT 0, 
	slhMod4_pmcID FOR COLUMN FK_PMCID4 INTEGER NOT NULL DEFAULT 0, 
	slhQuantity FOR COLUMN SLQUANTITY INTEGER NOT NULL DEFAULT 0, 
	slhCharge FOR COLUMN SLCHARGE DECIMAL(10,2) NOT NULL DEFAULT 0, 
	slhModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	slhModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	slhActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbServiceLineHoldingFile PRIMARY KEY( slhID )
);

/* Setting label text for tbServiceLineHoldingFile */
LABEL ON TABLE MDATA.SVCLNHLDFL IS 'tbServiceLineHoldingFile' ;

/* Setting table (Long) name for tbServiceLineHoldingFile (SVCLNHLDFL) */
RENAME TABLE MDATA.SVCLNHLDFL TO tbServiceLineHoldingFile FOR SYSTEM NAME SVCLNHLDFL;

--start journaling this table
--EXEC STRJRNPF  FILE(tbServiceLineHoldingFile)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(sidID ) AS PK FROM MDATA.tbServiceLinesDetail ;

DROP TABLE MDATA.tbServiceLinesDetail ;
---------------------------------------------------------------------------
-- tbServiceLinesDetail 
---------------------------------------------------------------------------
CREATE TABLE MDATA.SVCLNSDETL --tbServiceLinesDetail 
( 
	sidID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 3 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	sidInvoiceID_iadID FOR COLUMN FK_IADID INTEGER NOT NULL DEFAULT 0, 
	sidOrdinal FOR COLUMN SLDORDINAL INTEGER NOT NULL DEFAULT 0, 
	sidProcedureCode_prcID FOR COLUMN FK_PRCID INTEGER NOT NULL DEFAULT 0, 
	sidDiagnosisCode_dicID1 FOR COLUMN FK_DICID1 INTEGER NOT NULL DEFAULT 0, 
	sidDiagnosisCode_dicID2 FOR COLUMN FK_DICID2 INTEGER NOT NULL DEFAULT 0, 
	sidDiagnosisCode_dicID3 FOR COLUMN FK_DICID3 INTEGER NOT NULL DEFAULT 0, 
	sidDOS FOR COLUMN DOS CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sidDOS_To FOR COLUMN DOS_TO CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sidMonthend FOR COLUMN MONTHEND CHAR(10) CCSID 37 NOT NULL DEFAULT ' ',
	sidQty FOR COLUMN QTY INTEGER NOT NULL DEFAULT 0, 
	sidModifier1_pmcID FOR COLUMN FK_PMCID1 INTEGER NOT NULL DEFAULT 0, 
	sidModifier2_pmcID FOR COLUMN FK_PMCID2 INTEGER NOT NULL DEFAULT 0, 
	sidModifier3_pmcID FOR COLUMN FK_PMCID3 INTEGER NOT NULL DEFAULT 0, 
	sidTypeOnly FOR COLUMN TYPEONLY CHAR(1) NOT NULL DEFAULT ' ', 
	sidModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	sidModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	sidActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbServiceLinesDetail PRIMARY KEY( sidID )
);

/* Setting label text for tbServiceLinesDetail */
LABEL ON TABLE MDATA.SVCLNSDETL IS 'tbServiceLinesDetail' ;

/* Setting table (Long) name for tbServiceLinesDetail (SVCLNSDETL) */
RENAME TABLE MDATA.SVCLNSDETL TO tbServiceLinesDetail FOR SYSTEM NAME SVCLNSDETL;

--start journaling this table
--EXEC STRJRNPF  FILE(tbServiceLinesDetail)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(cvrID ) AS PK FROM MDATA.tbStandardRegistry ;

DROP TABLE MDATA.tbStandardRegistry ;
---------------------------------------------------------------------------
-- tbStandardRegistry 
---------------------------------------------------------------------------
CREATE TABLE MDATA.STDREG --tbStandardRegistry 
( 
	cvrID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 7523 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	cvrPracNum_cliID FOR COLUMN FK_CLIID CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrMedRecNum FOR COLUMN MEDRECNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrEncounterNum FOR COLUMN ENCNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatLastName FOR COLUMN PATLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatFirstName FOR COLUMN PATFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatGender FOR COLUMN PATGENDER CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatDOB FOR COLUMN PATDOB CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatAddress FOR COLUMN PATADDRESS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatCity FOR COLUMN PATCITY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatState FOR COLUMN PATSTATE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatZipCode FOR COLUMN PATZIPCODE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatAcceptAddress FOR COLUMN PATADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatPhone FOR COLUMN PATPHONE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPatSSN FOR COLUMN PATSSN CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrDOS FOR COLUMN DOS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrDrLastName FOR COLUMN DRLASTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrDrFirstName FOR COLUMN DRFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrRefDrLastName FOR COLUMN REFDRLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrRefDrFirstName FOR COLUMN REFDRFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrAdmitTime FOR COLUMN ADMITTIME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrDischargeTime FOR COLUMN DISCHGTIME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnLastName FOR COLUMN GRNLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnFirstName FOR COLUMN GRNFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnRelation FOR COLUMN GRNREL CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnAddress FOR COLUMN GRNADDRESS CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnCity FOR COLUMN GRNCITY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnState FOR COLUMN GRNSTATE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnZipcode FOR COLUMN GRNZIPCODE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnAcceptAddress FOR COLUMN GRNADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnPhone FOR COLUMN GRNPHONE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrGrnGender FOR COLUMN GRNGENDER CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrCostCenter FOR COLUMN COSTCENTER CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrTrtAuth1 FOR COLUMN TRTAUTH1 CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrTrtAuth2 FOR COLUMN TRTAUTH2 CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1Name FOR COLUMN INS1NAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1Address FOR COLUMN INS1ADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1City FOR COLUMN INS1CITY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1State FOR COLUMN INS1STATE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1Zipcode FOR COLUMN INS1ZIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1AcceptAddress FOR COLUMN INS1ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1Group FOR COLUMN INS1GROUP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1Contract FOR COLUMN INS1CONTR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1SubLastName FOR COLUMN INS1LNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1SubFirstName FOR COLUMN INS1FNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns1SubEmployer FOR COLUMN INS1EMPL CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2Name FOR COLUMN INS2NAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2Address FOR COLUMN INS2ADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2City FOR COLUMN INS2CITY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2State FOR COLUMN INS2STATE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2Zipcode FOR COLUMN INS2ZIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2AcceptAddress FOR COLUMN INS2ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2Group FOR COLUMN INS2GROUP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2Contract FOR COLUMN INS2CONTR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2SubLastName FOR COLUMN INS2LNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2SubFirstName FOR COLUMN INS2FNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns2SubEmployer FOR COLUMN INS2EMPL CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3Name FOR COLUMN INS3NAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3Address FOR COLUMN INS3ADDR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3City FOR COLUMN INS3CITY CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3State FOR COLUMN INS3STATE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3Zipcode FOR COLUMN INS3ZIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3AcceptAddress FOR COLUMN INS3ADDROK CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3Group FOR COLUMN INS3GROUP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3Contract FOR COLUMN INS3CONTR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3SubLastName FOR COLUMN INS3LNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3SubFirstName FOR COLUMN INS3FNAM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrIns3SubEmployer FOR COLUMN INS3EMPL CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrFileName FOR COLUMN FILENAM CHAR(255) CCSID 37 NOT NULL DEFAULT ' ',
	cvrFiller FOR COLUMN FILLER CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrAddressDifferent FOR COLUMN ADDRDIF CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrClientName FOR COLUMN CLIENTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrPrintTime FOR COLUMN PRINTTIME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	cvrErMessage FOR COLUMN ERMESSAGE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	CONSTRAINT MDATA.PK_tbStandardRegistry PRIMARY KEY( cvrID )
);

/* Setting label text for tbStandardRegistry */
LABEL ON TABLE MDATA.STDREG IS 'tbStandardRegistry' ;

/* Setting table (Long) name for tbStandardRegistry (STDREG) */
RENAME TABLE MDATA.STDREG TO tbStandardRegistry FOR SYSTEM NAME STDREG;

--start journaling this table
--EXEC STRJRNPF  FILE(tbStandardRegistry)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(staID ) AS PK FROM MDATA.tbState ;

DROP TABLE MDATA.Statelist ;
---------------------------------------------------------------------------
-- tbState 
---------------------------------------------------------------------------
CREATE TABLE MDATA.STATELIST --tbState 
( 
	staID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 74 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	staCountry_cntID FOR COLUMN FK_CNTID INTEGER NOT NULL DEFAULT 0, 
	staAbbreviation FOR COLUMN ABBR CHAR(2) CCSID 37 NOT NULL DEFAULT ' ',
	staName FOR COLUMN STATENAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	staModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	staModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	staActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbState PRIMARY KEY( staID )
);

/* Setting label text for tbState */
LABEL ON TABLE MDATA.STATELIST IS 'tbState' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbState FOR MDATA.STATELIST;

--start journaling this table
--EXEC STRJRNPF  FILE(tbState)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(stuID ) AS PK FROM MDATA.tbStudentMaster ;

DROP TABLE MDATA.tbStudentMaster ;
---------------------------------------------------------------------------
-- tbStudentMaster 
---------------------------------------------------------------------------
CREATE TABLE MDATA.STUMASTER --tbStudentMaster 
( 
	stuID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 117545 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	stuClient_cliID FOR COLUMN FK_CLIID INTEGER NOT NULL DEFAULT 0, 
	stuStudentID_SBSID FOR COLUMN FK_SBSID INTEGER NOT NULL DEFAULT 0, 
	stuStudentLastName FOR COLUMN STULNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stuStudentFirstName FOR COLUMN STUFNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stuStudentMiddleInitial FOR COLUMN STUMIDINL CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stuStudentBirthday FOR COLUMN STUBDAY CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	stuStudentSSN FOR COLUMN STUDENTSSN CHAR(9) CCSID 37 NOT NULL DEFAULT ' ',
	stuMedicaidNum FOR COLUMN MANUM CHAR(20) CCSID 37 NOT NULL DEFAULT ' ',
	stuGender FOR COLUMN GENDER CHAR(1) CCSID 37 NOT NULL DEFAULT ' ',
	stuLea_sccID FOR COLUMN FK_SCCID INTEGER NOT NULL DEFAULT 0, 
	stuAttendBuilding FOR COLUMN ATTENDBLDG CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stuGrade  CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stuTransElig FOR COLUMN TRANSELIG CHAR(1) NOT NULL DEFAULT ' ', 
	stuTransType FOR COLUMN TRANSTYPE CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	stuLastIEP FOR COLUMN LASTIEP CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	stuLastIDEA FOR COLUMN LASTIDEA CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	stuLastYYYYMM FOR COLUMN LASTYYYYMM INTEGER NOT NULL DEFAULT 0, 
	stuModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	stuModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	stuActive FOR COLUMN ACTIVE INTEGER NOT NULL DEFAULT 0, 
	CONSTRAINT MDATA.PK_tbStudentMaster PRIMARY KEY( stuID )
);

/* Setting label text for tbStudentMaster */
LABEL ON TABLE MDATA.STUMASTER IS 'tbStudentMaster' ;

/* Setting table (Long) name for tbStudentMaster (STUMASTER) */
RENAME TABLE MDATA.STUMASTER TO tbStudentMaster FOR SYSTEM NAME STUMASTER;

--start journaling this table
--EXEC STRJRNPF  FILE(tbStudentMaster)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(trcID ) AS PK FROM MDATA.tbTransactionCode ;

DROP TABLE MDATA.tbTransactionCode ;
---------------------------------------------------------------------------
-- tbTransactionCode 
---------------------------------------------------------------------------
CREATE TABLE MDATA.TRANCODE --tbTransactionCode 
( 
	trcID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	trcCode FOR COLUMN TRCODE INTEGER NOT NULL DEFAULT 0, 
	trcTransactionType_tctID FOR COLUMN FK_TCTID INTEGER NOT NULL DEFAULT 0, 
	trcDescription FOR COLUMN TRDESC CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	trcSystem FOR COLUMN TRSYSTEM CHAR(1) NOT NULL DEFAULT ' ', 
	trcEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	trcModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	trcModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	trcActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbTransactionCode PRIMARY KEY( trcID )
);

/* Setting label text for tbTransactionCode */
LABEL ON TABLE MDATA.TRANCODE IS 'tbTransactionCode' ;

/* Setting table (Long) name for tbTransactionCode (TRANCODE) */
RENAME TABLE MDATA.TRANCODE TO tbTransactionCode FOR SYSTEM NAME TRANCODE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbTransactionCode)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(tctID ) AS PK FROM MDATA.tbTransactionCodeType ;

DROP TABLE MDATA.tbTransactionCodeType ;
---------------------------------------------------------------------------
-- tbTransactionCodeType 
---------------------------------------------------------------------------
CREATE TABLE MDATA.TRANCDTYP --tbTransactionCodeType 
( 
	tctID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 5 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	tctDescription FOR COLUMN DESCRIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	tctRangeBegin FOR COLUMN RANGEBEGIN INTEGER NOT NULL DEFAULT 0, 
	tctRangeEnd FOR COLUMN RANGEEND INTEGER NOT NULL DEFAULT 0, 
	tctModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	tctModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	tctActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	tctBeginDate FOR COLUMN BEGINDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	tctEndDate FOR COLUMN ENDDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	CONSTRAINT MDATA.PK_tbTransactionCodeType PRIMARY KEY( tctID )
);

/* Setting label text for tbTransactionCodeType */
LABEL ON TABLE MDATA.TRANCDTYP IS 'tbTransactionCodeType' ;

/* Setting table (Long) name for tbTransactionCodeType (TRANCDTYP) */
RENAME TABLE MDATA.TRANCDTYP TO tbTransactionCodeType FOR SYSTEM NAME TRANCDTYP;

--start journaling this table
--EXEC STRJRNPF  FILE(tbTransactionCodeType)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(uacID ) AS PK FROM MDATA.tbUnappliedCash ;

DROP TABLE MDATA.tbUnappliedCash ;
---------------------------------------------------------------------------
-- tbUnappliedCash 
---------------------------------------------------------------------------
CREATE TABLE MDATA.UNAPPLCASH --tbUnappliedCash 
( 
	uacID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 1 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	uacPayor FOR COLUMN PAYOR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	uacCheckAmount FOR COLUMN CHKAMT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	uacUnappliedAmount FOR COLUMN UNAPPLAMT DECIMAL(9,2) NOT NULL DEFAULT 0, 
	uacCheckDate FOR COLUMN CHECKDATE CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	uacCheckNumber FOR COLUMN CHKNUM CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	uacDepositID_ddfID FOR COLUMN FK_DDFID INTEGER NOT NULL DEFAULT 0, 
	uacModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	uacModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	uacActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbUnappliedCash PRIMARY KEY( uacID )
);

/* Setting label text for tbUnappliedCash */
LABEL ON TABLE MDATA.UNAPPLCASH IS 'tbUnappliedCash' ;

/* Setting table (Long) name for tbUnappliedCash (UNAPPLCASH) */
RENAME TABLE MDATA.UNAPPLCASH TO tbUnappliedCash FOR SYSTEM NAME UNAPPLCASH;

--start journaling this table
--EXEC STRJRNPF  FILE(tbUnappliedCash)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(rolID ) AS PK FROM MDATA.tbUserRole ;

DROP TABLE MDATA.UserRole ;
---------------------------------------------------------------------------
-- tbUserRole 
---------------------------------------------------------------------------
CREATE TABLE MDATA.USERROLE --tbUserRole 
( 
	rolID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 43 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	rolWorkUnit_wudID FOR COLUMN FK_WUDID INTEGER NOT NULL DEFAULT 0, 
	rolName FOR COLUMN USRROLNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rolDescription FOR COLUMN DESCRIP CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	rolModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	rolModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	rolActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbUserRole PRIMARY KEY( rolID )
);

/* Setting label text for tbUserRole */
LABEL ON TABLE MDATA.USERROLE IS 'tbUserRole' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbUserRole FOR MDATA.USERROLE;

--start journaling this table
--EXEC STRJRNPF  FILE(tbUserRole)  JRN(MIPSTIM/JRNLDEFAULT)
--GO



--SELECT MAX(urpID ) AS PK FROM MDATA.tbUserRolePermissions ;

DROP TABLE MDATA.tbUserRolePermissions ;
---------------------------------------------------------------------------
-- tbUserRolePermissions 
---------------------------------------------------------------------------
CREATE TABLE MDATA.USRROLPERM --tbUserRolePermissions 
( 
	urpID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 2447 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	urpRole_rolID FOR COLUMN FK_ROLID INTEGER NOT NULL DEFAULT 0, 
	urpProcess_prcID FOR COLUMN FK_PRCID INTEGER NOT NULL DEFAULT 0, 
	urpPermission_prtID FOR COLUMN FK_PRTID INTEGER NOT NULL DEFAULT 0, 
	urpModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	urpModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	urpActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbUserRolePermissions PRIMARY KEY( urpID )
);

/* Setting label text for tbUserRolePermissions */
LABEL ON TABLE MDATA.USRROLPERM IS 'tbUserRolePermissions' ;

/* Setting table (Long) name for tbUserRolePermissions (USRROLPERM) */
RENAME TABLE MDATA.USRROLPERM TO tbUserRolePermissions FOR SYSTEM NAME USRROLPERM;

--start journaling this table
--EXEC STRJRNPF  FILE(tbUserRolePermissions)  JRN(MIPSTIM/JRNLDEFAULT)
--GO


--SELECT MAX(wudID ) AS PK FROM MDATA.tbWorkUnit ;

DROP TABLE MDATA.WorkUnit ;
---------------------------------------------------------------------------
-- tbWorkUnit 
---------------------------------------------------------------------------
CREATE TABLE MDATA.WORKUNIT --tbWorkUnit 
( 
	wudID INTEGER GENERATED ALWAYS AS IDENTITY ( START WITH 30 INCREMENT BY 1 NO MINVALUE NO MAXVALUE NO CYCLE NO ORDER CACHE 20 ), 

	wudDepartmentAbbr FOR COLUMN DEPTABBR CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	wudDepartmentName FOR COLUMN DEPTNAME CHAR(50) CCSID 37 NOT NULL DEFAULT ' ',
	wudModifiedDate FOR COLUMN MODIFIEDDT CHAR(10) CCSID 37 NOT NULL DEFAULT '1900-01-01', 
	wudModifiedBy_usrID FOR COLUMN MODIFIEDBY INTEGER NOT NULL DEFAULT 0, 
	wudActive FOR COLUMN ACTIVE CHAR(1) NOT NULL DEFAULT ' ', 
	CONSTRAINT MDATA.PK_tbWorkUnit PRIMARY KEY( wudID )
);

/* Setting label text for tbWorkUnit */
LABEL ON TABLE MDATA.WORKUNIT IS 'tbWorkUnit' ;

/* Set the alias for a table */
CREATE ALIAS MDATA.tbWorkUnit FOR MDATA.WORKUNIT;

--start journaling this table
--EXEC STRJRNPF  FILE(tbWorkUnit)  JRN(MIPSTIM/JRNLDEFAULT)
--GO

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
INSERT INTO MDATA.tbActivityHistoryType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbActivityHistoryType;

INSERT INTO MDATA.tbBATCH OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbBATCH;

INSERT INTO MDATA.tbBillingSource OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbBillingSource;

INSERT INTO MDATA.tbCDFCC OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbCDFCC;

INSERT INTO MDATA.tbCDFGI OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbCDFGI;

INSERT INTO MDATA.tbCDFMI (cliID, cliClientType_ctyID, cliClientState_staID, cliFederalEmployerIdentityNumber, cliStateCorporationNumber, cliNPI, cliClientName, cliBusinessAddress, cliBusinessCity, cliBusinessState_staID, cliBusinessZipcode, cliBusinessTelephone, cliMultiSite, cliEndProcessingDate, cliInvoiceAddress, cliInvoiceDeptNumber, cliInvoiceCity, cliInvoiceState_staID, cliInvoiceZipCode, cliInvoiceTelephone, cliInvoiceEmail, cliStopInvoicingDate, cliBankName, cliBankTelephone, cliElectronicRegistryExists, cliBeginDate, cliEndDate, cliRvuRegion, cliPurgePatientDemographics, cliPurgeClaims, cliModifiedDate, cliModifiedBy_usrID, cliActive) OVERRIDING SYSTEM VALUE
SELECT cliID, cliClientType_ctyID, cliClientState_staID, cliFederalEmployerIdentityNumber, cliStateCorporationNumber, cliNPI, cliClientName, cliBusinessAddress, cliBusinessCity, cliBusinessState_staID, cliBusinessZipcode, cliBusinessTelephone, cliMultiSite, cliEndProcessingDate, cliInvoiceAddress, cliInvoiceDeptNumber, cliInvoiceCity, cliInvoiceState_staID, cliInvoiceZipCode, cliInvoiceTelephone, cliInvoiceEmail, cliStopInvoicingDate, cliBankName, cliBankTelephone, cliElectronicRegistryExists, cliBeginDate, cliEndDate, cliRvuRegion, cliPurgePatientDemographics, cliPurgeClaims, cliModifiedDate, cliModifiedBy_usrID, cliActive FROM MIPSTIM.tbCDFMI;

INSERT INTO MDATA.tbCDFPI  (pvdID, pvdClient_cliID, pvdProviderType_pvtID, pvdFirstName, pvdLastName, pvdSocialSecurityNumber, pvdEMail, pvdProviderStatus_pvsID, pvdInternalNumber, pvdProviderPayrollCode_sccID, pvdMedicalLicenseNumber, pvdMedicalLicenseExpiryDate, pvdUserID, pvdPassword, pvdPasswordClue, pvdBeginDate, pvdEndDate, pvdLocumTenon_pvdID, pvdNationalProviderID, pvdUPIN, pvdModifiedDate, pvdModifiedBy_UsrID, pvdActive) OVERRIDING SYSTEM VALUE
SELECT pvdID, pvdClient_cliID, pvdProviderType_pvtID, pvdFirstName, pvdLastName, pvdSocialSecurityNumber, pvdEMail, pvdProviderStatus_pvsID, pvdInternalNumber, pvdProviderPayrollCode_sccID, Left(pvdMedicalLicenseNumber,7) AS pvdMedicalLicenseNumber, pvdMedicalLicenseExpiryDate, pvdUserID, pvdPassword, pvdPasswordClue, pvdBeginDate, pvdEndDate, pvdLocumTenon_pvdID, pvdNationalProviderID, pvdUPIN, pvdModifiedDate, pvdModifiedBy_UsrID, pvdActive FROM MIPSTIM.tbCDFPI;

INSERT INTO MDATA.tbCDFSchoolBuilding (sbdID, sbdCostCenter_csbID, sbdSchoolNumber, sbdName, sbdAddress, sbdCity, sbdState_staID, sbdZipcode, sbdModifiedDate, sbdModifiedBy_usrID, sbdActive) OVERRIDING SYSTEM VALUE
SELECT sbdID, sbdCostCenter_csbID, sbdSchoolNumber, sbdName, sbdAddress, sbdCity, sbdState_staID, sbdZipcode, sbdModifiedDate, sbdModifiedBy_usrID, sbdActive FROM Mipstim.tbCDFSchoolBuilding;

INSERT INTO MDATA.tbClaimHoldingFile (clhID, clhPatient_patID, clhRegistry_regid, clhClient_cliID, clhWorkstationID, clhStandardRegistry_shrID, clhNewLastName, clhNewFirstName, clhNewGender, clhNewDOB, clhNewAddress, clhNewCity, clhNewState_staID, clhNewZipcode, clhNewTelephone, clhNewSSN, clhNewMedicaid, clhNewMedicare, clhNewGuarLastName, clhNewGuarFirstName, clhNewGuarAddress, clhNewGuarCity, clhNewGuarState_staID, clhNewGuarZipcode, clhNewGuarRelationship_relID, clhAdmitDate, clhTriageTime, clhRenderingProvider_prvID, clhRenderingProviderName, clhReferingProvider_prvID, clhReferingProviderName, clhCostCenter_cerID, clhCostCenterName, clhAuthTreatNumber, clhChiefComplaint, clhComment, clhFileName, clhModifiedDate, clhModifiedBy_usrID, clhActive) OVERRIDING SYSTEM VALUE
SELECT clhID, clhPatient_patID, clhRegistry_regid, clhClient_cliID, clhWorkstationID, clhStandardRegistry_shrID, clhNewLastName, clhNewFirstName, clhNewGender, clhNewDOB, clhNewAddress, clhNewCity, clhNewState_staID, clhNewZipcode, clhNewTelephone, clhNewSSN, clhNewMedicaid, clhNewMedicare, clhNewGuarLastName, clhNewGuarFirstName, clhNewGuarAddress, clhNewGuarCity, clhNewGuarState_staID, clhNewGuarZipcode, clhNewGuarRelationship_relID, clhAdmitDate, clhTriageTime, clhRenderingProvider_prvID, clhRenderingProviderName, clhReferingProvider_prvID, clhReferingProviderName, clhCostCenter_cerID, clhCostCenterName, clhAuthTreatNumber, clhChiefComplaint, clhComment, clhFileName, clhModifiedDate, clhModifiedBy_usrID, clhActive FROM MIPSTIM.tbClaimHoldingFile;

INSERT INTO MDATA.tbClaimStatus OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbClaimStatus;

INSERT INTO MDATA.tbClientChargeMaster OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbClientChargeMaster;

INSERT INTO MDATA.tbClientType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbClientType;

--delete from mdata.tbCostCenter;
INSERT INTO MDATA.tbCostCenter (csbID, csbLEANumber, csbPOSID_posID, csbFacilityName, csbName, csbAddress, csbCity, csbState_staID, csbEmailAddress, csbPhoneNumber, csbZipCode, csbNPINumber, csbBeginDate, csbEndDate, csbModifiedDate, csbModifiedBy_usrID, csbActive) OVERRIDING SYSTEM VALUE
SELECT csbID, csbLEANumber, csbPOSID_posID, csbFacilityName, Left(csbName,50) AS csbName, csbAddress, csbCity, csbState_staID, csbEmailAddress, csbPhoneNumber, csbZipCode, csbNPINumber, csbBeginDate, csbEndDate, csbModifiedDate, csbModifiedBy_usrID, csbActive FROM MIPSTIM.tbCostCenter;

INSERT INTO MDATA.Country OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.Country;

INSERT INTO MDATA.tbDepositDetail OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbDepositDetail;

INSERT INTO MDATA.tbDepositType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbDepositType;

INSERT INTO MDATA.tbDiagnosisCode (dicID, dicDX_whoID, dicMBCDescription, dicSchoolBased, dicProfessional, dicProfessionalEmergency, dicInjury, dicCriticalCare, dicWorkRelated, dicProfessionalEndDate, dicSchoolBasedEndDate, dicModifiedDate, dicModifiedBy_usrID, dicActive) OVERRIDING SYSTEM VALUE
SELECT dicID, dicDX_whoID, dicMBCDescription, dicSchoolBased, dicProfessional, dicProfessionalEmergency, dicInjury, dicCriticalCare, dicWorkRelated, dicProfessionalEndDate, dicSchoolBasedEndDate, dicModifiedDate, dicModifiedBy_usrID, dicActive FROM MIPSTIM.tbDiagnosisCode;

INSERT INTO MDATA.tbDiagnosisCodeMaster (whoID, whoCode, whoDescription, whoSubdivision, whoModifiedDate, whoModifiedBy_usrID, whoActive) OVERRIDING SYSTEM VALUE
SELECT whoID, whoCode, whoDescription, whoSubdivision, whoModifiedDate, whoModifiedBy_usrID, whoActive FROM MIPSTIM.tbDiagnosisCodeMaster;

INSERT INTO MDATA.tbEmployeeProfile OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbEmployeeProfile;

INSERT INTO MDATA.tbEmployeeUserRole OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbEmployeeUserRole;

INSERT INTO MDATA.tbFederalFundsPortion OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbFederalFundsPortion;

INSERT INTO MDATA.tbInsuranceMaster (insID, insName, insFederalInsuranceNumber, insNumber, insAddress, insCity, insState_staID, insZipcode, insTelephone, insEmailAddress, insOCNA, insClearingHouseNumber, insClearingHousePayerNumber, insBillSrc_blsID, insElectronicCapable, insModifiedDate, insModifiedBy_usrID, insActive) OVERRIDING SYSTEM VALUE
SELECT insID, insName, insFederalInsuranceNumber, insNumber, insAddress, insCity, insState_staID, insZipcode, insTelephone, insEmailAddress, insOCNA, insClearingHouseNumber, insClearingHousePayerNumber, insBillSrc_blsID, insElectronicCapable, insModifiedDate, insModifiedBy_usrID, insActive FROM MIPSTIM.tbInsuranceMaster;

INSERT INTO MDATA.tbInsurancePaymentMaster OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbInsurancePaymentMaster;

INSERT INTO MDATA.tbInvoiceAncDetail OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbInvoiceAncDetail;

INSERT INTO MDATA.tbInvoiceBilledHistory OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbInvoiceBilledHistory;

INSERT INTO MDATA.tbInvoiceHistory OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbInvoiceHistory;

INSERT INTO MDATA.tbInvoiceInsurance OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbInvoiceInsurance;

INSERT INTO MDATA.tbInvoiceType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbInvoiceType;

INSERT INTO MDATA.tbMiscTran OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbMiscTran;

INSERT INTO MDATA.tbPatientClaimInsurance OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbPatientClaimInsurance;

INSERT INTO MDATA.tbPatientDemographicErrors OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbPatientDemographicErrors;

INSERT INTO MDATA.tbPatientDemographics (patID, patClient_cliID, patLastName, patFirstName, patAddress, patCity, patState_staID, patZipcode, patDOB, patGender, patSSN, patEmancipated, patGuarRelationship_relID, patGuarLastName, patGuarFirstName, patGuarAddress, patGuarCity, patGuarState_staID, patGuarZipcode, patPhone, patModifiedDate, patModifiedBy_usrID, patErrorMessage, patActive) OVERRIDING SYSTEM VALUE
SELECT patID, patClient_cliID, patLastName, patFirstName, patAddress, patCity, patState_staID, patZipcode, patDOB, patGender, patSSN, patEmancipated, patGuarRelationship_relID, patGuarLastName, patGuarFirstName, patGuarAddress, patGuarCity, patGuarState_staID, patGuarZipcode, patPhone, patModifiedDate, patModifiedBy_usrID, patErrorMessage, patActive FROM MIPSTIM.tbPatientDemographics;

INSERT INTO MDATA.tbPatientDemographicValidation (pacID, pacPatient_patID, pacRegistry_regID, pacNewLastName, pacNewFirstName, pacNewSex, pacNewDateOfBirth, pacNewAddress, pacNewCity, pacNewState_staID, pacNewZipCode, pacPatientAddressNotValid, pacAddressCheckErrMessage, pacNewTelephone, pacNewSocialSecurityNumber, pacNewMedicaidNumber, pacNewMedicareNumber, pacGuarRelationship_relID, pacGuarLastName, pacGuarFirstName, pacGuarAddress, pacGuarCity, pacGuarState_staID, pacGuarZipcode, pacGuarantorAddressNotValid, pacGuarantorAddressCheckErrMessage, pacGuarPhone, pacModifiedDate, pacModifiedBy_usrID, pacActive) OVERRIDING SYSTEM VALUE
SELECT pacID, pacPatient_patID, pacRegistry_regID, pacNewLastName, pacNewFirstName, pacNewSex, pacNewDateOfBirth, pacNewAddress, pacNewCity, pacNewState_staID, pacNewZipCode, pacPatientAddressNotValid, pacAddressCheckErrMessage, pacNewTelephone, pacNewSocialSecurityNumber, pacNewMedicaidNumber, pacNewMedicareNumber, pacGuarRelationship_relID, pacGuarLastName, pacGuarFirstName, pacGuarAddress, pacGuarCity, pacGuarState_staID, pacGuarZipcode, pacGuarantorAddressNotValid, pacGuarantorAddressCheckErrMessage, pacGuarPhone, pacModifiedDate, pacModifiedBy_usrID, pacActive FROM MIPSTIM.tbPatientDemographicValidation;

INSERT INTO MDATA.tbPatientInsurance OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbPatientInsurance;

INSERT INTO MDATA.tbPermissions OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbPermissions;

INSERT INTO MDATA.tbPlaceOfService OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbPlaceOfService;

INSERT INTO MDATA.tbProcedureClassClientType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcedureClassClientType;

delete from mdata.tbprocedurecode;
INSERT INTO MDATA.tbProcedureCode (rxcID, rxcCode, rxcDescription, rxcEndDate, rxcClassification_pclID, rxcRelativeValueUnit, rxcBillableCode, rxcStudentResponse, rxcTimesRequired, rxcMinimumMinutes, rxcPrescriptionRequired, rxcReferralRequired, rxcIdeaCode, rxcIepCode, rxcSBHSTransportation, rxcSBHSIndividualGroup, rxcRootCode, rxcAddOnCode, rxcQuantityRequired, rxcProcedureOnly, rxcConsultCode, rxcObservation, rxcAnesthesia, rxcInpatient, rxcCriticalCareCode, rxcInjuryCode, rxcNeedsModifier, rxcType_pctID, rxcSBHSTransportationAllowed, rxcSBHSCodeFrequencyDayRange, rxcSBHSCodeFrequencyNumber, rxcSBHSCodeQuantityPerDay, rxcSBHSQtyDayProvider, rxcSBHSDirectIntervention, rxcSBHSUnitDescription, rxcSBHSCode, rxcModifiedDate, rxcModifiedBy_usrID, rxcActive) OVERRIDING SYSTEM VALUE
SELECT rxcID, LEFT(rxcCode,5), LEFT(rxcDescription,240), rxcEndDate, rxcClassification_pclID, rxcRelativeValueUnit, rxcBillableCode, rxcStudentResponse, rxcTimesRequired, rxcMinimumMinutes, rxcPrescriptionRequired, rxcReferralRequired, rxcIdeaCode, rxcIepCode, rxcSBHSTransportation, rxcSBHSIndividualGroup, rxcRootCode, rxcAddOnCode, rxcQuantityRequired, rxcProcedureOnly, rxcConsultCode, rxcObservation, rxcAnesthesia, rxcInpatient, rxcCriticalCareCode, rxcInjuryCode, rxcNeedsModifier, rxcType_pctID, rxcSBHSTransportationAllowed, rxcSBHSCodeFrequencyDayRange, rxcSBHSCodeFrequencyNumber, rxcSBHSCodeQuantityPerDay, rxcSBHSQtyDayProvider, rxcSBHSDirectIntervention, rxcSBHSUnitDescription, rxcSBHSCode, rxcModifiedDate, rxcModifiedBy_usrID, rxcActive FROM MIPSTIM.tbProcedureCode;

INSERT INTO MDATA.tbProcedureCodeClassification OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcedureCodeClassification;

INSERT INTO MDATA.tbProcedureCodeClientType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcedureCodeClientType;

INSERT INTO MDATA.tbProcedureCodeStateBillLimitations OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcedureCodeStateBillLimitations;

INSERT INTO MDATA.tbProcedureModifierCode OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcedureModifierCode;

INSERT INTO MDATA.tbProcedureUsedModifiers OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcedureUsedModifiers;

INSERT INTO MDATA.tbProcess OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProcess;

INSERT INTO MDATA.tbProductionLog OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProductionLog;

INSERT INTO MDATA.tbProviderInsuranceNumber OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProviderInsuranceNumber;

INSERT INTO MDATA.tbProviderStatus OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProviderStatus;

INSERT INTO MDATA.tbProviderType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProviderType;

INSERT INTO MDATA.tbProviderTypeProcedureTable OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbProviderTypeProcedureTable;

INSERT INTO MDATA.tbRegistryLog OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbRegistryLog;

INSERT INTO MDATA.tbRegistryStatus OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbRegistryStatus;

INSERT INTO MDATA.tbRelationships OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbRelationships;

INSERT INTO MDATA.tbSchoolProcedureCodeState OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbSchoolProcedureCodeState;

INSERT INTO MDATA.tbSelfPayMessage OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbSelfPayMessage;

INSERT INTO MDATA.tbServiceLineFinancial OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbServiceLineFinancial;

INSERT INTO MDATA.tbServiceLineHoldingFile (slhID, slhClaim_clhID, slhOrdinal, slhDX_dicID, slhRX_prcID, slhMod1_pmcID, slhMod2_pmcID, slhMod3_pmcID, slhQuantity, slhCharge, slhModifiedDate, slhModifiedBy_usrID, slhActive) OVERRIDING SYSTEM VALUE
SELECT slhID, slhClaim_clhID, slhOrdinal, slhDX_dicID, slhRX_prcID, slhMod1_pmcID, slhMod2_pmcID, slhMod3_pmcID, slhQuantity, slhCharge, slhModifiedDate, slhModifiedBy_usrID, slhActive FROM MIPSTIM.tbServiceLineHoldingFile;

INSERT INTO MDATA.tbServiceLinesDetail OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbServiceLinesDetail;

INSERT INTO MDATA.tbStandardRegistry (cvrID, cvrPracNum_cliID, cvrMedRecNum, cvrEncounterNum, cvrPatLastName, cvrPatFirstName, cvrPatGender, cvrPatDOB, cvrPatAddress, cvrPatCity, cvrPatState, cvrPatZipCode, cvrPatPhone, cvrPatSSN, cvrDOS, cvrDrLastName, cvrDrFirstName, cvrRefDrLastName, cvrRefDrFirstName, cvrAdmitTime, cvrDischargeTime, cvrGrnLastName, cvrGrnFirstName, cvrGrnRelation, cvrGrnAddress, cvrGrnCity, cvrGrnState, cvrGrnZipcode, cvrGrnPhone, cvrGrnGender, cvrCostCenter, cvrTrtAuth1, cvrTrtAuth2, cvrIns1Name, cvrIns1Address, cvrIns1City, cvrIns1State, cvrIns1Zipcode, cvrIns1Group, cvrIns1Contract, cvrIns1SubLastName, cvrIns1SubFirstName, cvrIns1SubEmployer, cvrIns2Name, cvrIns2Address, cvrIns2City, cvrIns2State, cvrIns2Zipcode, cvrIns2Group, cvrIns2Contract, cvrIns2SubLastName, cvrIns2SubFirstName, cvrIns2SubEmployer, cvrIns3Name, cvrIns3Address, cvrIns3City, cvrIns3State, cvrIns3Zipcode, cvrIns3Group, cvrIns3Contract, cvrIns3SubLastName, cvrIns3SubFirstName, cvrIns3SubEmployer, cvrFileName, cvrFiller, cvrAddressDifferent, cvrClientName, cvrPrintTime, cvrErMessage) OVERRIDING SYSTEM VALUE
SELECT cvrID, cvrPracNum_cliID, cvrMedRecNum, cvrEncounterNum, cvrPatLastName, cvrPatFirstName, cvrPatGender, cvrPatDOB, cvrPatAddress, cvrPatCity, cvrPatState, cvrPatZipCode, cvrPatPhone, cvrPatSSN, cvrDOS, cvrDrLastName, cvrDrFirstName, cvrRefDrLastName, cvrRefDrFirstName, cvrAdmitTime, cvrDischargeTime, cvrGrnLastName, cvrGrnFirstName, cvrGrnRelation, cvrGrnAddress, cvrGrnCity, cvrGrnState, cvrGrnZipcode, cvrGrnPhone, cvrGrnGender, cvrCostCenter, cvrTrtAuth1, cvrTrtAuth2, cvrIns1Name, cvrIns1Address, cvrIns1City, cvrIns1State, cvrIns1Zipcode, cvrIns1Group, cvrIns1Contract, cvrIns1SubLastName, cvrIns1SubFirstName, cvrIns1SubEmployer, cvrIns2Name, cvrIns2Address, cvrIns2City, cvrIns2State, cvrIns2Zipcode, cvrIns2Group, cvrIns2Contract, cvrIns2SubLastName, cvrIns2SubFirstName, cvrIns2SubEmployer, cvrIns3Name, cvrIns3Address, cvrIns3City, cvrIns3State, cvrIns3Zipcode, cvrIns3Group, cvrIns3Contract, cvrIns3SubLastName, cvrIns3SubFirstName, cvrIns3SubEmployer, cvrFileName, cvrFiller, cvrAddressDifferent, cvrClientName, cvrPrintTime, cvrErMessage FROM MIPSTIM.tbStandardRegistry;

INSERT INTO MDATA.tbState OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbState;

INSERT INTO MDATA.tbStudentMaster OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbStudentMaster;

INSERT INTO MDATA.tbTransactionCode OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbTransactionCode;

INSERT INTO MDATA.tbTransactionCodeType OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbTransactionCodeType;

INSERT INTO MDATA.tbUnappliedCash OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbUnappliedCash;

INSERT INTO MDATA.tbUserRole OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbUserRole;

INSERT INTO MDATA.tbUserRolePermissions OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbUserRolePermissions;

INSERT INTO MDATA.tbWorkUnit OVERRIDING SYSTEM VALUE
SELECT * FROM MIPSTIM.tbWorkUnit;

----------------------------------fix busted-up data --------------------------------------------------------------
update mdata.tbCDFMI set climultisite=' ', clipurgepatientdemographics=' ', cliPurgeClaims=' ', cliStopInvoicingDate = '1900-01-01'; 
commit;

