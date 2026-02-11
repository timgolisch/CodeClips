
--testing code
-- exec spGetClosingPackage '0A146C8A-F78B-4171-9C89-049DB4A93D87'
-- select * from loanapplication
-- SELECT LoanNumber FROM LoanApplication WHERE LoanApplicationID='0A146C8A-F78B-4171-9C89-049DB4A93D87'
--end testing code


ALTER   PROCEDURE dbo.spGetClosingPackage (
	@LoanApplicationID UniqueIdentifier
)
AS

BEGIN 

DECLARE @LoanNum bigint
--SET @LoanNum = 1136555556
SELECT @LoanNum = LoanNumber FROM LoanApplication WHERE LoanApplicationID=@LoanApplicationID

--------
-- Observation: all of the fields in the temp table don't need to be there.  
-- If any of them were removed, infopath would still run the ClosingPackage form.
-- They have been left here for future use, etc.
--------

-------------
-- Approach:
-- First, create a temp table to hold the pre-xml structure.
-- This technique is much easier than doing a bunch of huge query statements and
-- UNIONing them together (like suggested in BooksOnLine).
-- It is a little less efficient, however, looking at a gigantic query with 
-- 25 UNION statements will make your eyes bleed.  This is much, much easier to
-- read and maintain.  I believe it is worth the performance that is sacrificed
-------------
CREATE TABLE #XmlOut
(
	Tag int,
	Parent int,
	[my:LoanApplication!1!xmlns:xsi] varchar(50),
	[my:LoanApplication!1!xmlns:my] varchar(100),
	[my:LoanApplication!1!xmlns:xd] varchar(50),
	[my:LoanApplication!1!xml:lang] varchar(10),
	[my:LoanApplication!1!my:loanNo!element] decimal(13,0), 
	[my:LoanApplication!1!my:loanType!element] varchar(20), 
	[my:LoanApplication!1!my:maxPrincipal!element] varchar(10), --decimal(13,0), 
	[my:LoanApplication!1!my:maxPrincipalText!element] varchar(10), --decimal(13,0), 
	[my:LoanApplication!1!my:closingDate!element] datetime, 
	[my:LoanApplication!1!my:formDate!element] datetime,
	[my:LoanApplication!1!my:endRescissionDate!element] varchar(10), --datetime, 
	[my:LoanApplication!1!my:lenderInitials!element] varchar(10), 
	[my:LoanApplication!1!my:countyName!element] varchar(30), 
	[my:LoanApplication!1!my:countyNo!element] varchar(15), 
	[my:LoanApplication!1!my:stateName!element] varchar(50),
	[my:Property!2!my:propertyAddress] varchar(30),
	[my:Property!2!my:propertyDescription] varchar(50),
	[my:Property!2!my:acres] varchar(8), --integer,
	[my:Property!2!my:reDistance] varchar(10),  --integer,
	[my:Property!2!my:reDirection] varchar(15),
	[my:Property!2!my:reLocality] varchar(18),
	[my:Property!2!my:reCounty] varchar(14),
	[my:PromissoryNotes!3!my:matDate!element] varchar(12), --datetime, 
	[my:PromissoryNotes!3!my:statedRate!element] varchar(5), --decimal(13,0), 
	[my:PromissoryNotes!3!my:rateType!element] varchar(20), 
	[my:PromissoryNotes!3!my:LoanPayments1!element] varchar(1), --placeholder for --	[my:LoanPayments1!4!my: !element] varchar(150), --verbiage block
	[my:PromissoryNotes!3!my:LoanPayments2!element] varchar(1), --placeholder for --	[my:LoanPayments2!5!my: !element] varchar(150), --verbiage block
	[my:PromissoryNotes!3!my:LoanPayments3!element] varchar(1), --placeholder for --	[my:LoanPayments3!6!my: !element] varchar(150), --verbiage block
	[my:PromissoryNotes!3!my:LoanPayments4!element] varchar(1), --placeholder for --	[my:LoanPayments4!7!my: !element] varchar(150), --verbiage block
	[my:PromissoryNotes!3!my:DraftProgram1!element] varchar(1), --placeholder for --	[my:DraftProgram1!8!my: !element] varchar(150), --verbiage block
	[my:PromissoryNotes!3!my:DraftProgram2!element] varchar(1), --placeholder for --	[my:DraftProgram2!9!my: !element] varchar(150), --verbiage block
	[my:PromissoryNotes!3!my:Collateral1!element] varchar(1),  --placeholder for --	[my:Collateral1!10!my: !element] varchar(150),  --verbiage block
	[my:PromissoryNotes!3!my:Collateral2!element] varchar(1),  --placeholder for --	[my:Collateral2!11!my: !element] varchar(150),  --verbiage block
	[my:PromissoryNotes!3!my:Collateral3!element] varchar(1),  --placeholder for --	[my:Collateral3!12!my: !element] varchar(150),  --verbiage block
	[my:PromissoryNotes!3!my:defaultPercent!element] varchar(4), --decimal(9,0),
	[my:PromissoryNotes!3!my:votingStockHolder!element] varchar(30), 
	[my:PromissoryNotes!3!my:Provision!element] varchar(1),--placeholder for --	[my:Provision!13!my: !element] varchar(150),    --verbiage block
	[my:PromissoryNotes!3!my:LoanCovenant!element] varchar(1),--placeholder for --	[my:LoanCovenant!14!my: !element] varchar(150), --verbiage block
	[my:PromissoryNote!4!my:noteDate!element] varchar(12), --datetime, 
	[my:PromissoryNote!4!my:noteFaceAmount!element] varchar(10), --decimal(13,0), 
	[my:PromissoryNote!4!my:noteMaturityDate!element] varchar(12), 
	[my:Entity!5!my:entityName!element] varchar(50), 
	[my:Entity!5!my:entity2Name!element] varchar(50), 
	[my:Entity!5!my:entityState!element] varchar(20), 
	[my:Entity!5!my:entityType!element] varchar(50), 
	[my:Entity!5!my:entity2State!element] varchar(20), 
	[my:Entity!5!my:entity2Type!element] varchar(50), 
	[my:SignerNames!16!my:Name!element] varchar(50), 
	[my:SignerName!17!my:typeName1!element] varchar(50), 
	[my:SignerName!17!my:typeName2!element] varchar(50),
	[my:Acknowledgements!18!my:Name!element] varchar(50), 
	[my:Individual!19!my:indState!element] varchar(20), 
	[my:Individual!19!my:indCounty!element] varchar(20), 
	[my:Individual!19!my:indNotaryDate!element] varchar(12), --datetime, 
	[my:Individual!19!my:indOfficerNames!element] varchar(150), 
	[my:Individual!19!my:indHhtOpt!element] varchar(10), 
	[my:Individual!19!my:indNotaryName!element] varchar(60), 
	[my:Individual!19!my:indNotaryCounty!element] varchar(30), 
	[my:Individual!19!my:indNotaryState!element] varchar(20), 
	[my:Individual!19!my:indNotaryCommExp!element] varchar(12), --datetime, 
	[my:Corporation!20!my:corpState!element] varchar(20), 
	[my:Corporation!20!my:corpCounty!element] varchar(30), 
	[my:Corporation!20!my:corpNotaryDate!element] varchar(12), --datetime, 
	[my:Corporation!20!my:corpOfficerNames!element] varchar(150), 
	[my:Corporation!20!my:corpHhtOpt!element] varchar(10), 
	[my:Corporation!20!my:corpNotaryName!element] varchar(60), 
	[my:Corporation!20!my:corpNotaryCounty!element] varchar(30), 
	[my:Corporation!20!my:corpNotaryState!element] varchar(20), 
	[my:Corporation!20!my:corpNotaryCommExp!element] varchar(12), --datetime, 
	[my:LimitedLiabilityCompany!21!my:llcState!element] varchar(20), 
	[my:LimitedLiabilityCompany!21!my:llcCounty!element] varchar(30), 
	[my:LimitedLiabilityCompany!21!my:llcNotaryDate!element] varchar(12), --datetime, 
	[my:LimitedLiabilityCompany!21!my:llcOfficerNames!element] varchar(150), 
	[my:LimitedLiabilityCompany!21!my:llcHhtOpt!element] varchar(10), 
	[my:LimitedLiabilityCompany!21!my:llcNotaryName!element] varchar(60), 
	[my:LimitedLiabilityCompany!21!my:llcNotaryCounty!element] varchar(30), 
	[my:LimitedLiabilityCompany!21!my:llcNotaryState!element] varchar(20), 
	[my:LimitedLiabilityCompany!21!my:llcNotaryCommExp!element] varchar(12), --datetime, 
	[my:Partnership!22!my:partnershipState!element] varchar(20), 
	[my:Partnership!22!my:partnershipCounty!element] varchar(30), 
	[my:Partnership!22!my:partnershipNotaryDate!element] varchar(12), --datetime, 
	[my:Partnership!22!my:partnershipOfficerNames!element] varchar(150), 
	[my:Partnership!22!my:partnershipHhtOpt!element] varchar(10), 
	[my:Partnership!22!my:partnershipNotaryName!element] varchar(60), 
	[my:Partnership!22!my:partnershipNotaryCounty!element] varchar(30), 
	[my:Partnership!22!my:partnershipNotaryState!element] varchar(20), 
	[my:Partnership!22!my:partnershipNotaryCommExp!element] varchar(12), --datetime, 
	[my:TrustOrEstate!23!my:trustState!element] varchar(20), 
	[my:TrustOrEstate!23!my:trustCounty!element] varchar(30), 
	[my:TrustOrEstate!23!my:trustNotaryDate!element] varchar(12), --datetime, 
	[my:TrustOrEstate!23!my:trustOfficerNames!element] varchar(150), 
	[my:TrustOrEstate!23!my:trustHhtOpt!element] varchar(10), 
	[my:TrustOrEstate!23!my:trustNotaryName!element] varchar(60), 
	[my:TrustOrEstate!23!my:trustNotaryCounty!element] varchar(30), 
	[my:TrustOrEstate!23!my:trustNotaryState!element] varchar(20), 
	[my:TrustOrEstate!23!my:trustNotaryCommExp!element] varchar(12), --datetime, 
	[my:Mortgage!24!my:mortgagorNames!element] varchar(150), 
	[my:Mortgage!24!my:mortgagorMailAddress!element] varchar(100), 
	[my:Mortgage!24!my:mtgDate!element] datetime, 
	[my:Mortgage!24!my:prinSum!element] varchar(10), --decimal(13,0), 
	[my:Mortgage!24!my:numOfNotes!element] varchar(10), 
	[my:Mortgage!24!my:attorneyCert!element] bit, 
	[my:Mortgage!24!my:attorneyNonCert!element] bit, 
	[my:Mortgage!24!my:processorName!element] varchar(100), 
	[my:Mortgage!24!my:branchAddress!element] varchar(100), 
	[my:Mortgage!24!my:branchCityStateZip!element] varchar(100), 
	[my:Mortgage!24!my:csrName!element] varchar(150), 
	[my:Mortgage!24!my:legalDescription!element] varchar(150), 
	[my:Mortgage!24!my:taxParcelID!element] varchar(50), 
	[my:Mortgage!24!my:mtgDateDay!element] varchar(2), 
	[my:Mortgage!24!my:mtgDateMonth!element] varchar(10), 
	[my:Mortgage!24!my:mtgDateYear!element] varchar(4), 
	[my:Mortgage!24!my:trusteeName!element] varchar(25), 
	[my:Mortgage!24!my:trusteeCityCounty!element] varchar(10), 
	[my:Mortgage!24!my:mortgageAmountText!element] varchar(10), 
	[my:Mortgage!24!my:witness1!element] varchar(10), 
	[my:Mortgage!24!my:witness2!element] varchar(10), 
	[my:Mortgage!24!my:witness3!element] varchar(10), 
	[my:Mortgage!24!my:witness4!element] varchar(10), 
	[my:RFTIN!25!my:assnNo!element] varchar(30), 
	[my:RFTIN!25!my:branchNo!element] varchar(20), 
	[my:RFTIN!25!my:cifNo!element] varchar(30), 
	[my:RFTIN!25!my:fsoNo!element] varchar(30), 
	[my:RFTIN!25!my:prepInit!element] varchar(30), 
	[my:RFTIN!25!my:inputDate!element] datetime, 
	[my:RFTIN!25!my:productCode!element] varchar(30), 
	[my:RFTIN!25!my:collateralCode!element] varchar(30), 
	[my:RFTIN!25!my:loanAmount!element] varchar(20), 
	[my:RFTIN!25!my:EIN!element] varchar(30), 
	[my:RFTIN!25!my:TIN!element] varchar(30), 
	[my:Borrowers!26!my:borrowerPrimaryName!element] varchar(50), 
	[my:Borrowers!26!my:borrowerAddress!element] varchar(50), 
	[my:Borrowers!26!my:borrowerCityStateZip!element] varchar(100), 
	[my:Borrowers!26!my:borrowerType!element] varchar(50), 
	[my:Borrower!27!my:borrowerName!element] varchar(50), 
	[my:Sellers!28!my:sellerPrimaryName!element] varchar(50), 
	[my:Sellers!28!my:sellerAddress!element] varchar(50), 
	[my:Sellers!28!my:sellerCityStateZip!element] varchar(100), 
	[my:Seller!29!my:name!element] varchar(50), 
	[my:Seller!29!my:streetAddress!element] varchar(50), 
	[my:Seller!29!my:city!element] varchar(50), 
	[my:Seller!29!my:state!element] varchar(50), 
	[my:Seller!29!my:zipCode!element] varchar(12), 
	[my:Seller!29!my:ssn!element] varchar(15), 
	[my:Seller!29!my:employerIdNumber!element] varchar(25), 
	[my:Seller!29!my:amtProceeds!element] varchar(12), --decimal(13,0), 
	[my:Seller!29!my:buyerTax!element] varchar(12), --decimal(13,0), 
--	[my:HUD!30!my: !element] varchar(150), --HUD is huge (15 folders elements, 500 elements), don't include it for now
		[my:HUD!30!my:fileNo!element] varchar(10),
		[my:HUD!30!my:pmiCaseNo!element] varchar(10),
		[my:HUD!30!my:propertyLocation!element] varchar(30),
		[my:HUD!30!my:settlementAgent!element] varchar(20),
		[my:HUD!30!my:settlementPlace!element] varchar(20),
		[my:HUD!30!my:settlementDate!element] varchar(10), --datetime
		[my:L700!37!my:salesPrice!element] varchar(10),
		[my:L700!37!my:commPercent!element] varchar(10),
		[my:L700!37!my:commAmt!element] varchar(10),
		[my:L700!37!my:rltr1CommAmt!element] varchar(10),
		[my:L700!37!my:rltr1Name!element] varchar(20),
		[my:L700!37!my:rltr2CommAmt!element] varchar(10),
		[my:L700!37!my:rltr2Name!element] varchar(20),
		[my:L800!38!my:lnAmt!element] varchar(10),
		[my:L800!38!my:feePercent!element] varchar(10),
		[my:L800!38!my:loanAmt!element] varchar(10),
		[my:L800!38!my:pointsPercent!element] varchar(5),
	[my:InsAck!46!Name!element] varchar(25), --placeholder
	[my:InsAck!46!my:chiYes!element] bit, 
	[my:InsAck!46!my:chiNo!element] bit, 
	[my:InsAck!46!my:chiComments!element] varchar(150), 
	[my:InsAck!46!my:mpciYes!element] bit, 
	[my:InsAck!46!my:mpciNo!element] bit, 
	[my:InsAck!46!my:mpciComments!element] varchar(150), 
	[my:InsAck!46!my:crpYes!element] bit, 
	[my:InsAck!46!my:crpNo!element] bit, 
	[my:InsAck!46!my:crpComments!element] varchar(150), 
	[my:InsAck!46!my:otherInsYes!element] bit, 
	[my:InsAck!46!my:otherInsNo!element] bit, 
	[my:InsAck!46!my:otherInsComments!element] varchar(150),
	[my:GLTL!47!my:gltlLifeOnlyYes!element] bit, 
	[my:GLTL!47!my:gltlLifeOnlyNo!element] bit, 
	[my:GLTL!47!my:gltlLifeDisabilityYes!element] bit, 
	[my:GLTL!47!my:gltlLifeDisabilityNo!element] bit, 
	[my:GLTL!47!my:gltlKeepCoverageSame!element] bit, 
	[my:GLTL!47!my:gltlIncrease!element] bit, 
	[my:GLTL!47!my:gltlDecrease!element] bit, 
	[my:GDTL!48!my:gdtlLifeOnlyYes!element] bit, 
	[my:GDTL!48!my:gdtlLifeOnlyNo!element] bit, 
	[my:GDTL!48!my:gdtlLifeDisabilityYes!element] bit, 
	[my:GDTL!48!my:gdtlLifeDisabilityNo!element] bit, 
	[my:GDTL!48!my:gdtlKeepCoverageSame!element] bit, 
	[my:GDTL!48!my:gdtlIncrease!element] bit, 
	[my:GDTL!48!my:gdtlDecrease!element] bit, 
	[my:ILTI!49!my:iltiYes!element] bit, 
	[my:ILTI!49!my:iltiNo!element] bit, 
	[my:ILTI!49!my:iltiKeepCoverageSame!element] bit, 
	[my:ILTI!49!my:iltiIncrease!element] bit, 
	[my:ILTI!49!my:iltiDecrease!element] bit, 
	--gap left here intentionally, in case renumbering ever occurs
	[my:SecurityAgreement!55!my:secAgreementDate!element] varchar(10), --DateTime
	[my:Tr1!56!my:tr1Acres!element] varchar(10),
	[my:Tr1!56!my:tr1Qtr!element] varchar(10),
	[my:Tr1!56!my:tr1Sec!element] varchar(10),
	[my:Tr1!56!my:tr1Twp!element] varchar(10),
	[my:Tr1!56!my:tr1Ns!element] varchar(10),
	[my:Tr1!56!my:tr1Rng!element] varchar(10),
	[my:Tr1!56!my:tr1Ew!element] varchar(10),
	[my:Tr1!56!my:tr1County!element] varchar(10),
	[my:Tr2!57!my:tr2Acres!element] varchar(10),
	[my:Tr2!57!my:tr2Qtr!element] varchar(10),
	[my:Tr2!57!my:tr2Sec!element] varchar(10),
	[my:Tr2!57!my:tr2Twp!element] varchar(10),
	[my:Tr2!57!my:tr2Ns!element] varchar(10),
	[my:Tr2!57!my:tr2Rng!element] varchar(10),
	[my:Tr2!57!my:tr2Ew!element] varchar(10),
	[my:Tr2!57!my:tr2County!element] varchar(10),
	[my:Tr3!58!my:tr3Acres!element] varchar(10),
	[my:Tr3!58!my:tr3Qtr!element] varchar(10),
	[my:Tr3!58!my:tr3Sec!element] varchar(10),
	[my:Tr3!58!my:tr3Twp!element] varchar(10),
	[my:Tr3!58!my:tr3Ns!element] varchar(10),
	[my:Tr3!58!my:tr3Rng!element] varchar(10),
	[my:Tr3!58!my:tr3Ew!element] varchar(10),
	[my:Tr3!58!my:tr3County!element] varchar(10),
	[my:Tr4!59!my:tr4Acres!element] varchar(10),
	[my:Tr4!59!my:tr4Qtr!element] varchar(10),
	[my:Tr4!59!my:tr4Sec!element] varchar(10),
	[my:Tr4!59!my:tr4Twp!element] varchar(10),
	[my:Tr4!59!my:tr4Ns!element] varchar(10),
	[my:Tr4!59!my:tr4Rng!element] varchar(10),
	[my:Tr4!59!my:tr4Ew!element] varchar(10),
	[my:Tr4!59!my:tr4County!element] varchar(10),
	[my:Tr5!60!my:tr5Acres!element] varchar(10),
	[my:Tr5!60!my:tr5Qtr!element] varchar(10),
	[my:Tr5!60!my:tr5Sec!element] varchar(10),
	[my:Tr5!60!my:tr5Twp!element] varchar(10),
	[my:Tr5!60!my:tr5Ns!element] varchar(10),
	[my:Tr5!60!my:tr5Rng!element] varchar(10),
	[my:Tr5!60!my:tr5Ew!element] varchar(10),
	[my:Tr5!60!my:tr5County!element] varchar(10),
	[my:SecurityAgreement!55!my:secureCrops!element] bit,
	[my:SecurityAgreement!55!my:secureLivestock!element] bit,
	[my:SecurityAgreement!55!my:secureSeed!element] bit,
	[my:SecurityAgreement!55!my:secureGeneral!element] bit,
	[my:SecurityAgreement!55!my:secureEquipment!element] bit,
	[my:SecurityAgreement!55!my:secureContact!element] bit,
	[my:SecurityAgreement!55!my:secureOtherProperty!element] bit,
	[my:SecurityAgreement!55!my:specificProperty!element] varchar(10),
	[my:SecurityAgreement!55!my:supplementDate!element] varchar(10),
	[my:Debtor!61!my:name!element] varchar(10), --placeholder
	[my:Debtors!62!my:name!element] varchar(10),  --placeholder
	[my:Entity1!63!my:entityName1!element] varchar(25), 
	[my:Entity2!64!my:entityName2!element] varchar(25), 
	[my:Debtor1!65!my:debtorName1!element] varchar(25), 
	[my:Debtor2!66!my:debtorName2!element] varchar(25), 
	[my:Debtor!61!my:debtorState!element] varchar(15), 
	--gap left intentionally to help if renumbering is needed in the future
	[my:HMDA!70!my:name!element] varchar(10),  --placeholder
	[my:Coder!71!my:msaCode!element] varchar(10), 
	[my:Coder!71!my:coderState!element] varchar(10), 
	[my:Coder!71!my:coderCounty!element] varchar(10), 
	[my:Coder!71!my:censusTract!element] varchar(10), 
	[my:Coder!71!my:appraisalDate!element] varchar(10), 
	[my:HMDA!70!my:typeResult!element] varchar(10), 
	[my:HMDA!70!my:propertyType!element] varchar(10), 
	[my:HMDA!70!my:sentDateHmda!element] varchar(10), 
	[my:HMDA!70!my:hmdaPurpose!element] varchar(10), 
	[my:HMDA!70!my:loanPurposeHmda!element] varchar(10), 
	[my:HMDA!70!my:hmdaOccupancyCode!element] varchar(10), 
	[my:HMDA!70!my:ownerOccHmda!element] varchar(10), 
	[my:HMDA!70!my:preApprCode!element] varchar(10), 
	[my:HMDA!70!my:hmdaPreApproval!element] varchar(10), 
	[my:Action!72!my:hmdaAction!element] varchar(10), 
	[my:Action!72!my:hmdaActionCode!element] varchar(1), 
	[my:Action!72!my:hmdaActionDate!element] varchar(10), 
	[my:Ethnicity!73!my:hmdaEthnicityApp!element] varchar(1), 
	[my:Ethnicity!73!my:hmdaEthnicityAppCode!element] varchar(1), 
	[my:Ethnicity!73!my:hmdaEthnicityCoapp!element] varchar(1), 
	[my:Ethnicity!73!my:hmdaEthnicityCoappCode!element] varchar(1), 
	[my:Race!74!my:hmdaRaceApp!element] varchar(14), 
	[my:Race!74!my:isHmdaRaceAppIndian!element] bit, 
	[my:Race!74!my:isHmdaRaceAppAsian!element] bit, 
	[my:Race!74!my:isHmdaRaceAppBlack!element] bit, 
	[my:Race!74!my:isHmdaRaceAppHawaiian!element] bit, 
	[my:Race!74!my:isHmdaRaceAppWhite!element] bit, 
	[my:Race!74!my:isHmdaRaceAppAnon!element] bit, 
	[my:Race!74!my:isHmdaRaceAppNa!element] bit, 
	[my:Race!74!my:hmdaRaceCoapp!element] varchar(14), 
	[my:Race!74!my:isHmdaRaceCoappIndian!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappAsian!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappBlack!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappHawaiian!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappWhite!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappAnon!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappNa!element] bit, 
	[my:Race!74!my:isHmdaRaceCoappNone!element] bit, 
	[my:Gender!75!my:hmdaGenderApp!element] varchar(1), 
	[my:Gender!75!my:hmdaGenderAppCode!element] varchar(1), 
	[my:Gender!75!my:hmdaGenderCoapp!element] varchar(1), 
	[my:Gender!75!my:hmdaGenderCoappCode!element] varchar(1), 
	[my:HMDA!70!my:hmdaAgi!element] varchar(1), 
	[my:HMDA!70!my:hmdaBuyerType!element] varchar(1), 
	[my:HMDA!70!my:hmdaBuyerTypeCode!element] varchar(1), 
	[my:ReasonForDenial!76!my:rfdDebtToIncomeRatio!element] bit, 
	[my:ReasonForDenial!76!my:rfdEmploymentHistory!element] bit, 
	[my:ReasonForDenial!76!my:rfdCreditHistory!element] bit, 
	[my:ReasonForDenial!76!my:rfdCollateral!element] bit, 
	[my:ReasonForDenial!76!my:rfdInsufficientCash!element] bit, 
	[my:ReasonForDenial!76!my:rfdUnverifiableInformation!element] bit, 
	[my:ReasonForDenial!76!my:rfdCreditAppIncomplete!element] bit, 
	[my:ReasonForDenial!76!my:rfdMortIsDenied!element] bit,  
	[my:ReasonForDenial!76!my:rfdOther!element] bit,  
	[my:HMDA!70!my:hmdaCompletedBy!element] varchar(10), 
	--gap left intentionally in case renumber is needed in the future
	[my:Officers!80!my:officerName!element] varchar(10),
	[my:Officers!80!my:officerTitle!element] varchar(10),
	[my:Officers!80!my:altOfficerName!element] varchar(10),
	[my:Officers!80!my:signerAlternate!element] varchar(10),
	[my:Officers!80!my:hasArticlesAttached!element] varchar(10),
	[my:Officers!80!my:hasArticlesPrevFurnished!element] varchar(10),
	[my:Officers!80!my:articlesDate!element] varchar(10),
	[my:Officers!80!my:bylawsDate!element] varchar(10),
	[my:Officers!80!my:meetingDte!element] varchar(10),
	[my:Officers!80!my:MeetingDayMonth!element] varchar(10),
	[my:Officers!80!my:meetingYearSuffix!element] varchar(10),
	[my:Officers!80!my:numberShares!element] varchar(10),
	[my:Officers!80!my:sharesValue!element] varchar(10),
	[my:Officers!80!my:numberStockholders!element] varchar(10),
	[my:Officers!80!my:farmerStockholders!element] varchar(10),
	[my:Officers!80!my:farmerStockValue!element] varchar(10),
	[my:Officers!80!my:owners!element] varchar(10),
	[my:Stockholders!81!presName!element] varchar(10),
	[my:Stockholders!81!presTitle!element] varchar(10),
	[my:Stockholders!81!presShares!element] varchar(10),
	[my:Stockholders!81!presTermExpires!element] varchar(10),
	[my:Stockholders!81!vpName!element] varchar(10),
	[my:Stockholders!81!vpTitle!element] varchar(10),
	[my:Stockholders!81!vpShares!element] varchar(10),
	[my:Stockholders!81!vpTermExpires!element] varchar(10),
	[my:Stockholders!81!secName!element] varchar(10),
	[my:Stockholders!81!secTitle!element] varchar(10),
	[my:Stockholders!81!secShares!element] varchar(10),
	[my:Stockholders!81!secTermExpires!element] varchar(10),
	[my:Stockholders!81!treasName!element] varchar(10),
	[my:Stockholders!81!treasTitle!element] varchar(10),
	[my:Stockholders!81!treasShares!element] varchar(10),
	[my:Stockholders!81!treasTermExpires!element] varchar(10),
	[my:Stockholders!81!asecName!element] varchar(10),
	[my:Stockholders!81!asecTitle!element] varchar(10),
	[my:Stockholders!81!asecShares!element] varchar(10),
	[my:Stockholders!81!asecTermExpires!element] varchar(10),
	[my:Stockholders!81!other1Name!element] varchar(10),
	[my:Stockholders!81!other1Title!element] varchar(10),
	[my:Stockholders!81!other1Shares!element] varchar(10),
	[my:Stockholders!81!other1TermExpires!element] varchar(10),
	[my:Stockholders!81!other2Name!element] varchar(10),
	[my:Stockholders!81!other2Title!element] varchar(10),
	[my:Stockholders!81!other2Shares!element] varchar(10),
	[my:Stockholders!81!other2TermExpires!element] varchar(10),
	[my:Stockholders!81!other3Name!element] varchar(10),
	[my:Stockholders!81!other3Title!element] varchar(10),
	[my:Stockholders!81!other3Shares!element] varchar(10),
	[my:Stockholders!81!other3TermExpires!element] varchar(10),
	[my:Stockholders!81!other4Name!element] varchar(10),
	[my:Stockholders!81!other4Title!element] varchar(10),
	[my:Stockholders!81!other4Shares!element] varchar(10),
	[my:Stockholders!81!other4TermExpires!element] varchar(10),
	[my:OperationDocuments!82!hasArticlesOfOperation!element] bit,
	[my:OperationDocuments!82!hasOperatingAgreement!element] bit,
	[my:OperationDocuments!82!hasMemberControlAgreement!element] bit,
	[my:Voters!83!voter1!element] varchar(10),
	[my:Voters!83!voter2!element] varchar(10),
	[my:Officers!80!my:certDay!element] varchar(10),
	[my:Officers!80!my:certMonth!element] varchar(10),
	[my:Officers!80!my:certYear!element] varchar(10),
	[my:Officers!80!my:offSigner!element] varchar(10),
	[my:Officers!80!my:offSignerTitle!element] varchar(10),
	[my:Company!84!corporationName!element] varchar(10),
	[my:Company!84!corporationState!element] varchar(10),
	[my:Company!84!licenseState!element] varchar(10),
	[my:Company!84!coManagement!element] varchar(10),
	[my:Company!84!coType!element] varchar(10),
	[my:Company!84!coShortRef!element] varchar(10),
	[my:Company!84!interests!element] varchar(10),
	[my:Company!84!hasGuarantee!element] bit,
	[my:Company!84!hasPledge!element] bit
)

----------
-- Most of these queries insert blank strings into columns
-- This was done so the XML structure could be verified during testing
-- In the future, when the data is available, it should make it easier to fill-in the blank fields
----------

-- LoanApplication --
INSERT INTO #XmlOut (Tag, Parent, 
	[my:LoanApplication!1!xmlns:xsi], [my:LoanApplication!1!xmlns:my], 
	[my:LoanApplication!1!xmlns:xd], [my:LoanApplication!1!xml:lang], 
	[my:LoanApplication!1!my:loanNo!element], [my:LoanApplication!1!my:loanType!element],
	[my:LoanApplication!1!my:maxPrincipal!element], [my:LoanApplication!1!my:closingDate!element], 
	[my:LoanApplication!1!my:formDate!element], [my:LoanApplication!1!my:endRescissionDate!element], 
	[my:LoanApplication!1!my:lenderInitials!element], [my:LoanApplication!1!my:countyName!element], 
	[my:LoanApplication!1!my:countyNo!element], [my:LoanApplication!1!my:stateName!element])
SELECT  1,
	NULL,
	'http://www.w3.org/2001/XMLSchema-instance',
	'http://schemas.microsoft.com/office/infopath/2003/myXSD/2005-04-17T21:35:20',
	'http://schemas.microsoft.com/office/infopath/2003',
	'en-us',
	LoanNumber,  
	'',
	'',
	EstimatedClosingDate, 
	GetDate(),
	'',
	'',
	County, 
	'County', 
	State
FROM  
	LoanApplication 
	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum

-- LoanApplication --
INSERT INTO #XmlOut (Tag, Parent, 
	[my:Property!2!my:propertyAddress],
	[my:Property!2!my:propertyDescription],
	[my:Property!2!my:acres], --integer,
	[my:Property!2!my:reDistance],  --integer,
	[my:Property!2!my:reDirection],
	[my:Property!2!my:reLocality],
	[my:Property!2!my:reCounty])
SELECT  2,
	1,
	NULL AS Address,
	[Description],
	TotalAcres,
	NULL AS Distance,
	NULL AS Direction,  
	Township,
	County
FROM  
	LoanApplication 
	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.LoanNumber = @LoanNum

-- PromissoryNotes --
INSERT INTO #XmlOut (Tag, Parent, 
	[my:PromissoryNotes!3!my:matDate!element],
	[my:PromissoryNotes!3!my:statedRate!element],
	[my:PromissoryNotes!3!my:rateType!element],
	[my:PromissoryNotes!3!my:LoanPayments1!element],
	[my:PromissoryNotes!3!my:LoanPayments2!element],
	[my:PromissoryNotes!3!my:LoanPayments3!element],
	[my:PromissoryNotes!3!my:LoanPayments4!element],
	[my:PromissoryNotes!3!my:DraftProgram1!element],
	[my:PromissoryNotes!3!my:DraftProgram2!element],
	[my:PromissoryNotes!3!my:Collateral1!element], 
	[my:PromissoryNotes!3!my:Collateral2!element], 
	[my:PromissoryNotes!3!my:Collateral3!element], 
	[my:PromissoryNotes!3!my:defaultPercent!element], 
	[my:PromissoryNotes!3!my:votingStockHolder!element], 
	[my:PromissoryNotes!3!my:Provision!element],
	[my:PromissoryNotes!3!my:LoanCovenant!element]
) 
VALUES(	3,
	1,
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'',
	'2.0',
	'',
	'',
	''
)

 -- PromissoryNote ----------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:PromissoryNote!4!my:noteDate!element], 
	[my:PromissoryNote!4!my:noteFaceAmount!element], 
	[my:PromissoryNote!4!my:noteMaturityDate!element]
)
SELECT 	4,
	3,
	'',
	'',
	''
FROM 
	LoanApplication
WHERE LoanApplication.Loannumber = @LoanNum



-- Entity --
INSERT INTO #XmlOut (Tag, Parent, 
	[my:Entity!5!my:entityName!element], 
	[my:Entity!5!my:entity2Name!element], 
	[my:Entity!5!my:entityState!element], 
	[my:Entity!5!my:entity2State!element], 
	[my:Entity!5!my:entityType!element], 
	[my:Entity!5!my:entity2Type!element]
)
SELECT 	5,
	1,
	'',
	'',
	[State], 
	[State],
	'',
	''
FROM 
	LoanApplication	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum


-- SignerNames --
INSERT INTO #XmlOut (Tag, Parent)
VALUES (16, 1)

-- SignerName --
INSERT INTO #XmlOut (Tag, Parent, [my:SignerName!17!my:typeName1!element], [my:SignerName!17!my:typeName2!element])
SELECT 17, 16, Signature1.SignatureName, Signature2.SignatureName
FROM Signature Signature1 LEFT JOIN Signature Signature2 
	ON Signature1.LoanApplicationID=Signature2.LoanApplicationID 
	AND Signature1.Sequence1=Signature2.Sequence1 
	AND Signature2.Sequence2=Signature1.Sequence2+1
WHERE Signature1.Sequence2 % 2 = 0  --even on the left, odd on the right
ORDER BY  Signature1.Sequence1, Signature1.Sequence2


-- Acknowledgements --
INSERT INTO #XmlOut (Tag, Parent)
VALUES (18, 1)

-- Individual --------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:Individual!19!my:indState!element], 
	[my:Individual!19!my:indCounty!element], 
	[my:Individual!19!my:indNotaryDate!element], 
	[my:Individual!19!my:indOfficerNames!element], 
	[my:Individual!19!my:indHhtOpt!element], 
	[my:Individual!19!my:indNotaryName!element], 
	[my:Individual!19!my:indNotaryCounty!element], 
	[my:Individual!19!my:indNotaryState!element], 
	[my:Individual!19!my:indNotaryCommExp!element])
SELECT	19,
	18,
	State,
	County,
	'',
	'',
	'',
	'',
	State,
	County,
	''
FROM 
	LoanApplication	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum

-- Corporation ------------------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:Corporation!20!my:corpState!element], 
	[my:Corporation!20!my:corpCounty!element], 
	[my:Corporation!20!my:corpNotaryDate!element], 
	[my:Corporation!20!my:corpOfficerNames!element], 
	[my:Corporation!20!my:corpHhtOpt!element], 
	[my:Corporation!20!my:corpNotaryName!element], 
	[my:Corporation!20!my:corpNotaryCounty!element], 
	[my:Corporation!20!my:corpNotaryState!element], 
	[my:Corporation!20!my:corpNotaryCommExp!element])
SELECT	20,
	18,
	State,
	County,
	'',
	'',
	'',
	'',
	State,
	County,
	''
FROM 
	LoanApplication	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum


-- LLC --------------------------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:LimitedLiabilityCompany!21!my:llcState!element], 
	[my:LimitedLiabilityCompany!21!my:llcCounty!element], 
	[my:LimitedLiabilityCompany!21!my:llcNotaryDate!element], 
	[my:LimitedLiabilityCompany!21!my:llcOfficerNames!element], 
	[my:LimitedLiabilityCompany!21!my:llcHhtOpt!element], 
	[my:LimitedLiabilityCompany!21!my:llcNotaryName!element], 
	[my:LimitedLiabilityCompany!21!my:llcNotaryCounty!element], 
	[my:LimitedLiabilityCompany!21!my:llcNotaryState!element], 
	[my:LimitedLiabilityCompany!21!my:llcNotaryCommExp!element])
SELECT	21,
	18,
	State,
	County,
	'',
	'',
	'',
	'',
	State,
	County,
	''
FROM 
	LoanApplication	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum


-- Partnership ------------------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:Partnership!22!my:partnershipState!element], 
	[my:Partnership!22!my:partnershipCounty!element], 
	[my:Partnership!22!my:partnershipNotaryDate!element], 
	[my:Partnership!22!my:partnershipOfficerNames!element], 
	[my:Partnership!22!my:partnershipHhtOpt!element], 
	[my:Partnership!22!my:partnershipNotaryName!element], 
	[my:Partnership!22!my:partnershipNotaryCounty!element], 
	[my:Partnership!22!my:partnershipNotaryState!element], 
	[my:Partnership!22!my:partnershipNotaryCommExp!element])
SELECT	22,
	18,
	State,
	County,
	'',
	'',
	'',
	'',
	State,
	County,
	''
FROM 
	LoanApplication	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum


-- Trust or Estate --------------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:TrustOrEstate!23!my:trustState!element], 
	[my:TrustOrEstate!23!my:trustCounty!element], 
	[my:TrustOrEstate!23!my:trustNotaryDate!element], 
	[my:TrustOrEstate!23!my:trustOfficerNames!element], 
	[my:TrustOrEstate!23!my:trustHhtOpt!element], 
	[my:TrustOrEstate!23!my:trustNotaryName!element], 
	[my:TrustOrEstate!23!my:trustNotaryCounty!element], 
	[my:TrustOrEstate!23!my:trustNotaryState!element], 
	[my:TrustOrEstate!23!my:trustNotaryCommExp!element])
SELECT	23,
	18,
	State,
	County,
	'',
	'',
	'',
	'',
	State,
	County,
	''
FROM 
	LoanApplication	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.Loannumber = @LoanNum


-- Mortgage ---------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:Mortgage!24!my:mortgagorNames!element], 
	[my:Mortgage!24!my:mortgagorMailAddress!element], 
	[my:Mortgage!24!my:mtgDate!element], 
	[my:Mortgage!24!my:prinSum!element], 
	[my:Mortgage!24!my:numOfNotes!element], 
	[my:Mortgage!24!my:attorneyCert!element], 
	[my:Mortgage!24!my:attorneyNonCert!element], 
	[my:Mortgage!24!my:processorName!element], 
	[my:Mortgage!24!my:branchAddress!element], 
	[my:Mortgage!24!my:branchCityStateZip!element], 
	[my:Mortgage!24!my:csrName!element], 
	[my:Mortgage!24!my:legalDescription!element], 
	[my:Mortgage!24!my:taxParcelID!element],
	[my:Mortgage!24!my:mtgDateDay!element],
	[my:Mortgage!24!my:mtgDateMonth!element],
	[my:Mortgage!24!my:mtgDateYear!element],
	[my:Mortgage!24!my:trusteeName!element],
	[my:Mortgage!24!my:trusteeCityCounty!element],
	[my:Mortgage!24!my:mortgageAmountText!element],
	[my:Mortgage!24!my:witness1!element],
	[my:Mortgage!24!my:witness2!element],
	[my:Mortgage!24!my:witness3!element],
	[my:Mortgage!24!my:witness4!element]) 
SELECT 24, 1,
	'',
	'',
	ScheduledClosingDate,
	'',
	NumberOfNotesSecured,
	0,
	0,--attorneyNonCert
	'',
	'',--branch address (we have branchId, but the branch table doesn't have this info)
	'',
	'',--csr name
	'',
	'',
	Day(ScheduledClosingDate),--mtgDateDay
	Month(ScheduledClosingDate),
	Year(ScheduledClosingDate),
	'',
	'',
	'', --dbo.MoneyToWords(AmountRequested ,1),
	'', --witness1...
	'',
	'',
	''
FROM LoanApplication
WHERE LoanApplication.Loannumber = @LoanNum


-- RFTIN ------------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:RFTIN!25!my:assnNo!element], 
	[my:RFTIN!25!my:branchNo!element], 
	[my:RFTIN!25!my:cifNo!element], 
	[my:RFTIN!25!my:fsoNo!element], 
	[my:RFTIN!25!my:prepInit!element], 
	[my:RFTIN!25!my:inputDate!element], 
	[my:RFTIN!25!my:productCode!element], 
	[my:RFTIN!25!my:collateralCode!element], 
	[my:RFTIN!25!my:loanAmount!element], 
	[my:RFTIN!25!my:EIN!element], 
	[my:RFTIN!25!my:TIN!element])
SELECT 25, 1,
	'',
	BranchId,
	'',
	'',
	'',
	SubmittedOn,
	ProductCode,
	'',
	Convert(VarChar, AmountRequested),
	null,
	null
FROM LoanApplication
WHERE LoanApplication.Loannumber = @LoanNum


-- Borrowers --------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:Borrowers!26!my:borrowerPrimaryName!element], 
	[my:Borrowers!26!my:borrowerAddress!element], 
	[my:Borrowers!26!my:borrowerCityStateZip!element]
)
VALUES (26, 1, '', '', '')

-- Borrower ---------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:Borrower!27!my:borrowerName!element]
)
VALUES (27, 26, '')


-- Sellers ----------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:Sellers!28!my:sellerPrimaryName!element], 
	[my:Sellers!28!my:sellerAddress!element], 
	[my:Sellers!28!my:sellerCityStateZip!element]
)
VALUES (28, 1, '', '', '')

-- Seller -----------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:Seller!29!my:name!element], 
	[my:Seller!29!my:streetAddress!element], 
	[my:Seller!29!my:city!element], 
	[my:Seller!29!my:state!element], 
	[my:Seller!29!my:zipCode!element], 
	[my:Seller!29!my:ssn!element], 
	[my:Seller!29!my:employerIdNumber!element], 
	[my:Seller!29!my:amtProceeds!element], 
	[my:Seller!29!my:buyerTax!element] 
)
VALUES (29, 28, '', '', '', '', '', '', '', '', '')


-- HUD --------------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:HUD!30!my:fileNo!element],
	[my:HUD!30!my:pmiCaseNo!element],
	[my:HUD!30!my:propertyLocation!element],
	[my:HUD!30!my:settlementAgent!element],
	[my:HUD!30!my:settlementPlace!element],
	[my:HUD!30!my:settlementDate!element]
)
SELECT 30, 1, 
	NULL, 
	NULL, 
	[Description],
	NULL,
	NULL,
	NULL
FROM  
	LoanApplication 
	LEFT JOIN CollateralItem ON LoanApplication.LoanApplicationID = CollateralItem.LoanApplicationID
WHERE LoanApplication.LoanNumber = @LoanNum

-- J100, J200, J300, K400, K500, K600 ...
INSERT INTO #XmlOut (Tag, Parent,
	[my:L700!37!my:salesPrice!element],
	[my:L700!37!my:commPercent!element],
	[my:L700!37!my:commAmt!element],
	[my:L700!37!my:rltr1CommAmt!element],
	[my:L700!37!my:rltr1Name!element],
	[my:L700!37!my:rltr2CommAmt!element],
	[my:L700!37!my:rltr2Name!element]
)
SELECT 37, 30, 
	Convert(VarChar,AmountRequested),
	NULL, NULL, NULL, NULL,	NULL,
	NULL
FROM  
	LoanApplication 
WHERE LoanApplication.LoanNumber = @LoanNum

INSERT INTO #XmlOut (Tag, Parent,
	[my:L800!38!my:lnAmt!element],
	[my:L800!38!my:feePercent!element],
	[my:L800!38!my:loanAmt!element],
	[my:L800!38!my:pointsPercent!element]
)
SELECT 37, 30, 
	NULL, 
	NULL,
	Convert(VarChar,ApprovedRequestAmount),
	NULL
FROM  
	LoanApplication 
WHERE LoanApplication.LoanNumber = @LoanNum
-- ...L900, L1000, L1100, L1200, L1300, L1400


-- InsAck -----------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:InsAck!46!my:chiYes!element], 
	[my:InsAck!46!my:chiNo!element], 
	[my:InsAck!46!my:chiComments!element], 
	[my:InsAck!46!my:mpciYes!element], 
	[my:InsAck!46!my:mpciNo!element], 
	[my:InsAck!46!my:mpciComments!element], 
	[my:InsAck!46!my:crpYes!element], 
	[my:InsAck!46!my:crpNo!element], 
	[my:InsAck!46!my:crpComments!element], 
	[my:InsAck!46!my:otherInsYes!element], 
	[my:InsAck!46!my:otherInsNo!element], 
	[my:InsAck!46!my:otherInsComments!element]
)
VALUES (46, 1, 0, 0, '', 0, 0, '', 0, 0, '', 0, 0, '')

-- GLTL -------------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:GLTL!47!my:gltlLifeOnlyYes!element], 
	[my:GLTL!47!my:gltlLifeOnlyNo!element], 
	[my:GLTL!47!my:gltlLifeDisabilityYes!element], 
	[my:GLTL!47!my:gltlLifeDisabilityNo!element], 
	[my:GLTL!47!my:gltlKeepCoverageSame!element], 
	[my:GLTL!47!my:gltlIncrease!element], 
	[my:GLTL!47!my:gltlDecrease!element]
)
VALUES (47, 46, 0, 0, 0, 0, 0, 0, 0)

-- GDTL -------------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:GDTL!48!my:gdtlLifeOnlyYes!element], 
	[my:GDTL!48!my:gdtlLifeOnlyNo!element], 
	[my:GDTL!48!my:gdtlLifeDisabilityYes!element], 
	[my:GDTL!48!my:gdtlLifeDisabilityNo!element], 
	[my:GDTL!48!my:gdtlKeepCoverageSame!element], 
	[my:GDTL!48!my:gdtlIncrease!element], 
	[my:GDTL!48!my:gdtlDecrease!element]
)
VALUES (48, 46, 0, 0, 0, 0, 0, 0, 0)

-- ILTI -------------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:ILTI!49!my:iltiYes!element], 
	[my:ILTI!49!my:iltiNo!element], 
	[my:ILTI!49!my:iltiKeepCoverageSame!element], 
	[my:ILTI!49!my:iltiIncrease!element], 
	[my:ILTI!49!my:iltiDecrease!element]
)
VALUES (49, 46, 0, 0, 0, 0, 0)


-- Security Agreement -----------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:SecurityAgreement!55!my:secAgreementDate!element],
	[my:SecurityAgreement!55!my:secureCrops!element] ,
	[my:SecurityAgreement!55!my:secureLivestock!element] ,
	[my:SecurityAgreement!55!my:secureSeed!element] ,
	[my:SecurityAgreement!55!my:secureGeneral!element] ,
	[my:SecurityAgreement!55!my:secureEquipment!element],
	[my:SecurityAgreement!55!my:secureContact!element] ,
	[my:SecurityAgreement!55!my:secureOtherProperty!element] ,
	[my:SecurityAgreement!55!my:specificProperty!element],
	[my:SecurityAgreement!55!my:supplementDate!element] 
)
VALUES (55, 1, 
	'', 
	'', 
	'', 
	'', 
	'', 
	'', 
	'', 
	'', 
	'', 
	''
)

INSERT INTO #XmlOut (Tag, Parent,
	[my:Tr1!56!my:tr1Acres!element],
	[my:Tr1!56!my:tr1Qtr!element] ,
	[my:Tr1!56!my:tr1Sec!element] ,
	[my:Tr1!56!my:tr1Twp!element] ,
	[my:Tr1!56!my:tr1Ns!element] ,
	[my:Tr1!56!my:tr1Rng!element] ,
	[my:Tr1!56!my:tr1Ew!element] ,
	[my:Tr1!56!my:tr1County!element] 
)
SELECT 56, 55,
	'', 
	'', 
	[Section], 
	Township, 
	'', 
	Range, 
	'', 
	County
FROM  	LoanApplication INNER JOIN CollateralItem 
	ON LoanApplication.LoanApplicationId = CollateralItem.LoanApplicationID AND SequenceNumber=1
WHERE LoanApplication.LoanNumber = @LoanNum

INSERT INTO #XmlOut (Tag, Parent,
	[my:Tr2!57!my:tr2Acres!element] ,
	[my:Tr2!57!my:tr2Qtr!element] ,
	[my:Tr2!57!my:tr2Sec!element] ,
	[my:Tr2!57!my:tr2Twp!element] ,
	[my:Tr2!57!my:tr2Ns!element] ,
	[my:Tr2!57!my:tr2Rng!element] ,
	[my:Tr2!57!my:tr2Ew!element] ,
	[my:Tr2!57!my:tr2County!element] 
)
SELECT 57, 55,
	'', 
	'', 
	[Section], 
	Township, 
	'', 
	Range, 
	'', 
	County
FROM  	LoanApplication INNER JOIN CollateralItem 
	ON LoanApplication.LoanApplicationId = CollateralItem.LoanApplicationID AND SequenceNumber=2
WHERE LoanApplication.LoanNumber = @LoanNum

INSERT INTO #XmlOut (Tag, Parent,
	[my:Tr3!58!my:tr3Acres!element] ,
	[my:Tr3!58!my:tr3Qtr!element] ,
	[my:Tr3!58!my:tr3Sec!element] ,
	[my:Tr3!58!my:tr3Twp!element] ,
	[my:Tr3!58!my:tr3Ns!element] ,
	[my:Tr3!58!my:tr3Rng!element] ,
	[my:Tr3!58!my:tr3Ew!element] ,
	[my:Tr3!58!my:tr3County!element] 
)
SELECT 58, 55,
	'', 
	'', 
	[Section], 
	Township, 
	'', 
	Range, 
	'', 
	County
FROM  	LoanApplication INNER JOIN CollateralItem 
	ON LoanApplication.LoanApplicationId = CollateralItem.LoanApplicationID AND SequenceNumber=3
WHERE LoanApplication.LoanNumber = @LoanNum

INSERT INTO #XmlOut (Tag, Parent,
	[my:Tr4!59!my:tr4Acres!element] ,
	[my:Tr4!59!my:tr4Qtr!element] ,
	[my:Tr4!59!my:tr4Sec!element] ,
	[my:Tr4!59!my:tr4Twp!element] ,
	[my:Tr4!59!my:tr4Ns!element] ,
	[my:Tr4!59!my:tr4Rng!element] ,
	[my:Tr4!59!my:tr4Ew!element] ,
	[my:Tr4!59!my:tr4County!element]
)
SELECT 59, 55, 
	'', 
	'', 
	[Section], 
	Township, 
	'', 
	Range, 
	'', 
	County
FROM  	LoanApplication INNER JOIN CollateralItem 
	ON LoanApplication.LoanApplicationId = CollateralItem.LoanApplicationID AND SequenceNumber=4
WHERE LoanApplication.LoanNumber = @LoanNum

INSERT INTO #XmlOut (Tag, Parent,
	[my:Tr5!60!my:tr5Acres!element] ,
	[my:Tr5!60!my:tr5Qtr!element] ,
	[my:Tr5!60!my:tr5Sec!element] ,
	[my:Tr5!60!my:tr5Twp!element] ,
	[my:Tr5!60!my:tr5Ns!element] ,
	[my:Tr5!60!my:tr5Rng!element] ,
	[my:Tr5!60!my:tr5Ew!element] ,
	[my:Tr5!60!my:tr5County!element] 
)
SELECT 60, 55, 
	'', 
	'', 
	[Section], 
	Township, 
	'', 
	Range, 
	'', 
	County
FROM  	LoanApplication INNER JOIN CollateralItem 
	ON LoanApplication.LoanApplicationId = CollateralItem.LoanApplicationID AND SequenceNumber=5
WHERE LoanApplication.LoanNumber = @LoanNum


/*


-- Debtor ---------------------------------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:Debtor!61!my:name!element] varchar(10), --placeholder
	[my:Debtor!61!my:debtorState!element]
)
SELECT 61, 1,
	NULL,
	State
FROM LoanApplication
WHERE LoanApplication.Loannumber = @LoanNum


INSERT INTO #XmlOut (Tag, Parent, 
	[my:Debtors!62!my:name!element]  --placeholder
)
VALUES (62, 61, NULL)

INSERT INTO #XmlOut (Tag, Parent, 
	[my:Entity1!63!my:entityName1!element]
)
VALUES (63, 62, NULL)

INSERT INTO #XmlOut (Tag, Parent, 
	[my:Entity2!64!my:entityName2!element] 
)
VALUES (64, 62, NULL)

INSERT INTO #XmlOut (Tag, Parent, 
	[my:Debtor1!65!my:debtorName1!element] 
)
VALUES (65, 62, NULL)

INSERT INTO #XmlOut (Tag, Parent, 
	[my:Debtor2!66!my:debtorName2!element] 
)
VALUES (66, 62, NULL)

*/

-- HMDA -------------------------------
INSERT INTO #XmlOut (Tag, Parent, 
	[my:HMDA!70!my:typeResult!element] , 
	[my:HMDA!70!my:propertyType!element] , 
	[my:HMDA!70!my:sentDateHmda!element] , 
	[my:HMDA!70!my:hmdaPurpose!element] , 
	[my:HMDA!70!my:loanPurposeHmda!element] , 
	[my:HMDA!70!my:hmdaOccupancyCode!element] , 
	[my:HMDA!70!my:ownerOccHmda!element] , 
	[my:HMDA!70!my:preApprCode!element] , 
	[my:HMDA!70!my:hmdaPreApproval!element] , 
	[my:HMDA!70!my:hmdaAgi!element] , 
	[my:HMDA!70!my:hmdaBuyerType!element] , 
	[my:HMDA!70!my:hmdaBuyerTypeCode!element] , 
	[my:HMDA!70!my:hmdaCompletedBy!element]  
)
VALUES (70, 1, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null
)

INSERT INTO #XmlOut (Tag, Parent,
	[my:Coder!71!my:msaCode!element] , 
	[my:Coder!71!my:coderState!element] , 
	[my:Coder!71!my:coderCounty!element] , 
	[my:Coder!71!my:censusTract!element] , 
	[my:Coder!71!my:appraisalDate!element]
)
SELECT 71, 70,
	null, 
	State,
	County,
	null, 
	EvaluationDate
FROM LoanApplication INNER JOIN CollateralItem ON LoanApplication.LoanApplicationId = CollateralItem.LoanApplicationId
WHERE LoanApplication.Loannumber = @LoanNum


INSERT INTO #XmlOut (Tag, Parent,
	[my:Action!72!my:hmdaAction!element] ,
	[my:Action!72!my:hmdaActionCode!element],
	[my:Action!72!my:hmdaActionDate!element]
)
VALUES (72, 70, 
	null, null, null
)
--select * from ethnicity
INSERT INTO #XmlOut (Tag, Parent,
	[my:Ethnicity!73!my:hmdaEthnicityApp!element],
	[my:Ethnicity!73!my:hmdaEthnicityAppCode!element],
	[my:Ethnicity!73!my:hmdaEthnicityCoapp!element],
	[my:Ethnicity!73!my:hmdaEthnicityCoappCode!element]
)
SELECT 73, 70,  
	CASE 
		WHEN AppEthnicity.Name='Hispanic' OR AppEthnicity.Name='Latino' THEN 1
		WHEN NOT AppEthnicity.EthnicityId IS NULL THEN 2
		WHEN AppEthnicity.EthnicityId IS NULL THEN 3
		ELSE 4
	END,
	CASE 
		WHEN AppEthnicity.Name='Hispanic' OR AppEthnicity.Name='Latino' THEN 1
		WHEN NOT AppEthnicity.EthnicityId IS NULL THEN 2
		WHEN AppEthnicity.EthnicityId IS NULL THEN 3
		ELSE 4
	END,
	CASE 
		WHEN CoappEthnicity.Name='Hispanic' OR CoappEthnicity.Name='Latino' THEN 1
		WHEN NOT CoappEthnicity.EthnicityId IS NULL THEN 2
		WHEN CoappEthnicity.EthnicityId IS NULL THEN 3
		ELSE 4
	END,
	CASE 
		WHEN CoappEthnicity.Name='Hispanic' OR AppEthnicity.Name='Latino' THEN 1
		WHEN (NOT CoappEthnicity.EthnicityId IS NULL) AND (NOT Coapp.ApplicantId IS NULL) THEN 2
		WHEN (CoappEthnicity.EthnicityId IS NULL) AND (NOT Coapp.ApplicantId IS NULL) THEN 3
		ELSE 4
	END
FROM LoanApplication INNER JOIN Applicant App ON LoanApplication.LoanApplicationId = App.LoanApplicationId
	INNER JOIN ApplicantRole AppRole ON App.ApplicantRoleId = AppRole.ApplicantRoleId AND AppRole.Name='Primary'
	LEFT JOIN Ethnicity AppEthnicity ON App.EthnicityId = AppEthnicity.EthnicityId
	LEFT JOIN 
	(Applicant Coapp INNER JOIN ApplicantRole CoappRole ON Coapp.ApplicantRoleId = CoappRole.ApplicantRoleId AND CoappRole.Name='Co-applicant'
		LEFT JOIN Ethnicity CoappEthnicity ON Coapp.EthnicityId = CoappEthnicity.EthnicityId
		) ON LoanApplication.LoanApplicationId = Coapp.LoanApplicationId
WHERE LoanApplication.Loannumber = @LoanNum

--select * from RaceOrNationalOrigin
INSERT INTO #XmlOut (Tag, Parent,
	[my:Race!74!my:hmdaRaceApp!element],
	[my:Race!74!my:isHmdaRaceAppIndian!element],
	[my:Race!74!my:isHmdaRaceAppAsian!element], 
	[my:Race!74!my:isHmdaRaceAppBlack!element], 
	[my:Race!74!my:isHmdaRaceAppHawaiian!element], 
	[my:Race!74!my:isHmdaRaceAppWhite!element], 
	[my:Race!74!my:isHmdaRaceAppAnon!element], 
	[my:Race!74!my:isHmdaRaceAppNa!element], 
	[my:Race!74!my:hmdaRaceCoapp!element], 
	[my:Race!74!my:isHmdaRaceCoappIndian!element], 
	[my:Race!74!my:isHmdaRaceCoappAsian!element], 
	[my:Race!74!my:isHmdaRaceCoappBlack!element], 
	[my:Race!74!my:isHmdaRaceCoappHawaiian!element], 
	[my:Race!74!my:isHmdaRaceCoappWhite!element], 
	[my:Race!74!my:isHmdaRaceCoappAnon!element], 
	[my:Race!74!my:isHmdaRaceCoappNa!element], 
	[my:Race!74!my:isHmdaRaceCoappNone!element]
)
SELECT 74, 70,
	NULL,
	CASE 	WHEN AppRaceIndian.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN AppRaceAsian.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN AppRaceBlack.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN AppRaceHawaiian.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN AppRaceWhite.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN AppRaceNone.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	NULL,
	NULL,
	CASE 	WHEN CoAppRaceIndian.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN CoAppRaceAsian.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN CoAppRaceBlack.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN CoAppRaceHawaiian.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN CoAppRaceWhite.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	CASE 	WHEN CoAppRaceNone.RaceOrNationalOriginId IS NULL THEN Cast(0 AS Bit)
		ELSE Cast(1 AS Bit)
	END,
	NULL,
	CASE 	WHEN CoApp.LoanApplicationId IS NULL THEN Cast(1 AS Bit)
		ELSE Cast(0 AS Bit)
	END
FROM LoanApplication 
	INNER JOIN Applicant App ON LoanApplication.LoanApplicationId = App.LoanApplicationId
	INNER JOIN ApplicantRole AppRole ON App.ApplicantRoleId = AppRole.ApplicantRoleId AND AppRole.Name='Primary'
		LEFT JOIN (Applicant_RaceOrNationalOrigin ARONO1 INNER JOIN RaceOrNationalOrigin AppRaceIndian   ON ARONO1.RaceOrNationalOriginId = AppRaceIndian.RaceOrNationalOriginId   AND AppRaceIndian.Name  ='American Indian or Alaskan Native') ON App.ApplicantID=ARONO1.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin ARONO2 INNER JOIN RaceOrNationalOrigin AppRaceAsian    ON ARONO2.RaceOrNationalOriginId = AppRaceAsian.RaceOrNationalOriginId    AND AppRaceAsian.Name   ='Asian') ON App.ApplicantID=ARONO2.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin ARONO3 INNER JOIN RaceOrNationalOrigin AppRaceBlack    ON ARONO3.RaceOrNationalOriginId = AppRaceBlack.RaceOrNationalOriginId    AND AppRaceBlack.Name   ='Black or African American') ON App.ApplicantID=ARONO3.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin ARONO4 INNER JOIN RaceOrNationalOrigin AppRaceHawaiian ON ARONO4.RaceOrNationalOriginId = AppRaceHawaiian.RaceOrNationalOriginId AND AppRaceHawaiian.Name='Native Hawaiian or Other Pacific Islander') ON App.ApplicantID=ARONO4.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin ARONO5 INNER JOIN RaceOrNationalOrigin AppRaceWhite    ON ARONO5.RaceOrNationalOriginId = AppRaceWhite.RaceOrNationalOriginId    AND AppRaceWhite.Name   ='White') ON App.ApplicantID=ARONO5.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin ARONO6 INNER JOIN RaceOrNationalOrigin AppRaceNone     ON ARONO6.RaceOrNationalOriginId = AppRaceNone.RaceOrNationalOriginId     AND AppRaceNone.Name    ='Not Provided') ON App.ApplicantID=ARONO6.ApplicantID
	LEFT JOIN 
	(Applicant Coapp 
		LEFT JOIN (Applicant_RaceOrNationalOrigin CRONO1 INNER JOIN RaceOrNationalOrigin CoAppRaceIndian   ON CRONO1.RaceOrNationalOriginId = CoAppRaceIndian.RaceOrNationalOriginId   AND CoAppRaceIndian.Name  ='American Indian or Alaskan Native') ON CoApp.ApplicantID=CRONO1.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin CRONO2 INNER JOIN RaceOrNationalOrigin CoAppRaceAsian    ON CRONO2.RaceOrNationalOriginId = CoAppRaceAsian.RaceOrNationalOriginId    AND CoAppRaceAsian.Name   ='Asian') ON CoApp.ApplicantID=CRONO2.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin CRONO3 INNER JOIN RaceOrNationalOrigin CoAppRaceBlack    ON CRONO3.RaceOrNationalOriginId = CoAppRaceBlack.RaceOrNationalOriginId    AND CoAppRaceBlack.Name   ='Black or African American') ON CoApp.ApplicantID=CRONO3.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin CRONO4 INNER JOIN RaceOrNationalOrigin CoAppRaceHawaiian ON CRONO4.RaceOrNationalOriginId = CoAppRaceHawaiian.RaceOrNationalOriginId AND CoAppRaceHawaiian.Name='Native Hawaiian or Other Pacific Islander') ON CoApp.ApplicantID=CRONO4.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin CRONO5 INNER JOIN RaceOrNationalOrigin CoAppRaceWhite    ON CRONO5.RaceOrNationalOriginId = CoAppRaceWhite.RaceOrNationalOriginId    AND CoAppRaceWhite.Name   ='White') ON CoApp.ApplicantID=CRONO5.ApplicantID
		LEFT JOIN (Applicant_RaceOrNationalOrigin CRONO6 INNER JOIN RaceOrNationalOrigin CoAppRaceNone     ON CRONO6.RaceOrNationalOriginId = CoAppRaceNone.RaceOrNationalOriginId     AND CoAppRaceNone.Name    ='Not Provided') ON CoApp.ApplicantID=CRONO6.ApplicantID
	) ON LoanApplication.LoanApplicationId = Coapp.LoanApplicationId
WHERE LoanApplication.Loannumber = @LoanNum
 
INSERT INTO #XmlOut (Tag, Parent,
	[my:Gender!75!my:hmdaGenderApp!element] , 
	[my:Gender!75!my:hmdaGenderAppCode!element] , 
	[my:Gender!75!my:hmdaGenderCoapp!element] , 
	[my:Gender!75!my:hmdaGenderCoappCode!element] 
)
VALUES (75, 70,
	null, null, null, null
)

INSERT INTO #XmlOut (Tag, Parent,
	[my:ReasonForDenial!76!my:rfdDebtToIncomeRatio!element] , 
	[my:ReasonForDenial!76!my:rfdEmploymentHistory!element] , 
	[my:ReasonForDenial!76!my:rfdCreditHistory!element] , 
	[my:ReasonForDenial!76!my:rfdCollateral!element] , 
	[my:ReasonForDenial!76!my:rfdInsufficientCash!element] , 
	[my:ReasonForDenial!76!my:rfdUnverifiableInformation!element] , 
	[my:ReasonForDenial!76!my:rfdCreditAppIncomplete!element] , 
	[my:ReasonForDenial!76!my:rfdMortIsDenied!element] ,  
	[my:ReasonForDenial!76!my:rfdOther!element] 
)
VALUES (76, 70,
	null, null, null, null, null, 
	null, null, null, null
)

/*--===========================================================================


-- Officers ---------------------------
INSERT INTO #XmlOut (Tag, Parent,
	[my:Officers!80!my:officerName!element] ,
	[my:Officers!80!my:officerTitle!element] ,
	[my:Officers!80!my:altOfficerName!element] ,
	[my:Officers!80!my:signerAlternate!element] ,
	[my:Officers!80!my:hasArticlesAttached!element] ,
	[my:Officers!80!my:hasArticlesPrevFurnished!element] ,
	[my:Officers!80!my:articlesDate!element] ,
	[my:Officers!80!my:bylawsDate!element] ,
	[my:Officers!80!my:meetingDte!element] ,
	[my:Officers!80!my:MeetingDayMonth!element] ,
	[my:Officers!80!my:meetingYearSuffix!element] ,
	[my:Officers!80!my:numberShares!element] ,
	[my:Officers!80!my:sharesValue!element] ,
	[my:Officers!80!my:numberStockholders!element] ,
	[my:Officers!80!my:farmerStockholders!element] ,
	[my:Officers!80!my:farmerStockValue!element] ,
	[my:Officers!80!my:owners!element] ,
	[my:Officers!80!my:certDay!element] ,
	[my:Officers!80!my:certMonth!element],
	[my:Officers!80!my:certYear!element] ,
	[my:Officers!80!my:offSigner!element] ,
	[my:Officers!80!my:offSignerTitle!element] 
)
VALUES (80, 1,
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null
)

INSERT INTO #XmlOut (Tag, Parent,
	[my:Stockholders!81!presName!element] ,
	[my:Stockholders!81!presTitle!element] ,
	[my:Stockholders!81!presShares!element] ,
	[my:Stockholders!81!presTermExpires!element] ,
	[my:Stockholders!81!vpName!element] ,
	[my:Stockholders!81!vpTitle!element] ,
	[my:Stockholders!81!vpShares!element] ,
	[my:Stockholders!81!vpTermExpires!element] ,
	[my:Stockholders!81!secName!element] ,
	[my:Stockholders!81!secTitle!element] ,
	[my:Stockholders!81!secShares!element] ,
	[my:Stockholders!81!secTermExpires!element] ,
	[my:Stockholders!81!treasName!element] ,
	[my:Stockholders!81!treasTitle!element] ,
	[my:Stockholders!81!treasShares!element] ,
	[my:Stockholders!81!treasTermExpires!element] ,
	[my:Stockholders!81!asecName!element] ,
	[my:Stockholders!81!asecTitle!element] ,
	[my:Stockholders!81!asecShares!element] ,
	[my:Stockholders!81!asecTermExpires!element] ,
	[my:Stockholders!81!other1Name!element] ,
	[my:Stockholders!81!other1Title!element] ,
	[my:Stockholders!81!other1Shares!element] ,
	[my:Stockholders!81!other1TermExpires!element] ,
	[my:Stockholders!81!other2Name!element] ,
	[my:Stockholders!81!other2Title!element] ,
	[my:Stockholders!81!other2Shares!element] ,
	[my:Stockholders!81!other2TermExpires!element] ,
	[my:Stockholders!81!other3Name!element] ,
	[my:Stockholders!81!other3Title!element] ,
	[my:Stockholders!81!other3Shares!element] ,
	[my:Stockholders!81!other3TermExpires!element] ,
	[my:Stockholders!81!other4Name!element] ,
	[my:Stockholders!81!other4Title!element] ,
	[my:Stockholders!81!other4Shares!element] ,
	[my:Stockholders!81!other4TermExpires!element] 
)
VALUES (81, 80,
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null, null, null, null, null, 
	null
)

INSERT INTO #XmlOut (
	[my:OperationDocuments!82!hasArticlesOfOperation!element],
	[my:OperationDocuments!82!hasOperatingAgreement!element],
	[my:OperationDocuments!82!hasMemberControlAgreement!element]
)
VALUES (82, 80, 
	null, null, null
)

INSERT INTO #XmlOut (
	[my:Voters!83!voter1!element],
	[my:Voters!83!voter2!element] 
)
VALUES (83, 80, 
	null, null
)

-- Company ----------------------------
INSERT INTO #XmlOut (
	[my:Company!84!corporationName!element],
	[my:Company!84!corporationState!element],
	[my:Company!84!licenseState!element] ,
	[my:Company!84!coManagement!element] ,
	[my:Company!84!coType!element] ,
	[my:Company!84!coShortRef!element],
	[my:Company!84!interests!element] ,
	[my:Company!84!hasGuarantee!element],
	[my:Company!84!hasPledge!element]
)
VALUES (82, 80, 
	null, null, null, null, null,
	null, null, null, null
)


*/

-------------------------------------------------------------------------------
-- final select
---------------
SELECT * FROM #XmlOut
FOR XML EXPLICIT


-- clean up after ourselves
DROP TABLE #XmlOut


END



