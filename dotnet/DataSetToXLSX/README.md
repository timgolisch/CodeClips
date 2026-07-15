# DataSet to XLSX

There are 4 parts to this

1. A demo app. It is a single winform (exe) that runs and demonstrates how the code works.

&#x20;1a. "Preview Xml Serialization" generates the serialized objects into a textbox on the screen so you can inspect (troubleshoot, etc)

&#x20;1b. "OpenXml File" produces a .xslx file and puts it on your harddrive. You can choose the save path and filename in the top right.

&#x20;1c. "Excel Xml File" was the old approach, prior to xslx, but still works really well. After the file is generated, you can double-click it and (if you have MS Office installed) you will be asked how you want to view it. Choose "Office xml handler". 

I usually output the Excel Xml file from a web app. When I do, I also add 2 output headers: 

* response.setContentType("application/vnd.ms-excel"); //so the browser knows this is an excel file.
* response.setHeader("Content-Disposition", "attachment;filename=\\"ExcelDemo.xls\\"");// suggested "save as" filename



2. Serializable objects. Excel is build on a structure like: File, Tabs (worksheets), rows, columns.  It also has formatting information for each of those, and the ability to include formulas, etc. I didn't get too deep into those. Help youself.
3. File generators. There are two different ways to output the data. The old way is xml, which still works with excel, but is a little clunky.
The new way is using Open Xml. This library comes from nuget and is considered to be the modern standard.
4. Fake data is generated in a function called GetDummyData(). You can fiddle around with that to try different data types, column sizes, multiple tables/tabs, etc.

