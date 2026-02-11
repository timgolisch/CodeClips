private const cSTYLE as string = _
" <Styles>" & vbcrlf & _
"  <Style ss:ID=""Default"" ss:Name=""Normal"">" & vbcrlf & _
"   <Alignment ss:Vertical=""Bottom""/>" & vbcrlf & _
"   <Borders/>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""11"" ss:Color=""#000000""/>" & vbcrlf & _
"   <Interior/>" & vbcrlf & _
"   <NumberFormat/>" & vbcrlf & _
"   <Protection/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s57"" ss:Name=""RegularCell"">" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s58"" ss:Name=""ReportSubHeader"">" & vbcrlf & _
"   <Alignment ss:Horizontal=""Left"" ss:Vertical=""Bottom""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#606010"" ss:Bold=""1""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s59"" ss:Name=""GridHeader"">" & vbcrlf & _
"   <Alignment ss:Horizontal=""Center"" ss:Vertical=""Center"" ss:WrapText=""1""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000"" ss:Bold=""1""/>" & vbcrlf & _
"   <Interior ss:Color=""#BDB6A6"" ss:Pattern=""Solid""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s60"" ss:Name=""GridRow"">" & vbcrlf & _
"   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s61"" ss:Name=""GridRowNumeric"">" & vbcrlf & _
"   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbcrlf & _
"   <NumberFormat ss:Format=""0""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s62"" ss:Name=""GridRowAlt"">" & vbcrlf & _
"   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbcrlf & _
"   <Interior ss:Color=""#EDE8DF"" ss:Pattern=""Solid""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s63"" ss:Name=""GridRowAltNumeric"">" & vbcrlf & _
"   <Alignment ss:Vertical=""Bottom"" ss:WrapText=""1""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#000000""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Color=""#000000""/>" & vbcrlf & _
"   <Interior ss:Color=""#EDE8DF"" ss:Pattern=""Solid""/>" & vbcrlf & _
"   <NumberFormat ss:Format=""0""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
"  <Style ss:ID=""s64"" ss:Name=""ReportTitle"">" & vbcrlf & _
"   <Alignment ss:Horizontal=""Center"" ss:Vertical=""Bottom""/>" & vbcrlf & _
"   <Borders>" & vbcrlf & _
"    <Border ss:Position=""Bottom"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Left"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Right"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"    <Border ss:Position=""Top"" ss:LineStyle=""Continuous"" ss:Weight=""1"" ss:Color=""#CCCCCC""/>" & vbcrlf & _
"   </Borders>" & vbcrlf & _
"   <Font ss:FontName=""Calibri"" x:Family=""Swiss"" ss:Size=""12"" ss:Color=""#000000""" & vbcrlf & _
"    ss:Bold=""1""/>" & vbcrlf & _
"  </Style>" & vbcrlf & _
" </Styles>" & vbcrlf

