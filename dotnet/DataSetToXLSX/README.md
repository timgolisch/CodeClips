# DataSet to XLSX

There are 4 parts to this

1. A demo app. It is a single winform (exe) that runs and demonstrates how the other 3 parts work. 

  "Using Open Xml" produces a .xslx file and puts it on your harddrive in a folder and file (picked at the top right)
  "Using Xml Serialization" generates the serialized objects into a textbox on the screen so you can inspect (troubleshoot, etc)
  "Using Excel Xml" was the old approach, prior to xslx, but still works. You can output this from a web app and as long as your output headers identify the file as the correct type, a browser will open an excel reader to display the content.

  Some fake data is generated in a function called GetDummyData(). You can fiddle around with that to try different data types, column sizes, etc.

2. Serializable objects. Excel is build on a structure like: File, Tabs (worksheets), rows, columns.  It also has formatting information for each of those, and the ability to include formulas, etc. I didn't get too deep into those. Help youself.

3. File generators. There are two different ways to output the data. The old way is xml, which still works with excel, but is a little clunky.
   The new way is using Open Xml. This library comes from nuget and is considered to be the modern standard.

