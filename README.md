# SQLite-Net.Extensions.Readers
Extension readers for https://github.com/praeclarum/sqlite-net project.

This extension let to query the database without binding to a specific class.
The results are Dictionnary of <string, object>. Each key contains ColumnName, Value contains data.

## Build 

[![Build status](https://ci.appveyor.com/api/projects/status/6j1xyjwxsyp98p2i/branch/master?svg=true)](https://ci.appveyor.com/project/mathieumack/sqlite-net-extensions-readers/branch/master)

## Nuget

[![NuGet package](https://buildstats.info/nuget/SQLite-Net.Extensions.Readers?includePreReleases=true)](https://nuget.org/packages/SQLite-Net.Extensions.Readers)

## Platform Support

| Platform | Available 
| --- | --- |
| PCL (Profile 111) | &#x2713; |

## Onboarding Instructions 
1. Add nuget package: 

    Install-Package MvvX.Plugins.HockeyApp
2. In your source file, add the following line in usage declaration section:
    <pre>using SQLite_Net.Extensions.Readers;</pre>
3. In your source file, call ExecuteReader method
	<pre>var readerResults = connection.ExecuteReader("SQL Query");</pre>

## Example
```C#
void ExecuteCustomQuery(SQLiteConnection connection)
{
	var tableName = "<SetTableName>";
	// Execute reader :
	var readerResults = connection.ExecuteReader("SELECT * FROM " + tableName);
	Console.WriteLine("Read data from table " + tableName);
	// Showing results :
	foreach (var readerItem in readerResults)
		Console.WriteLine(string.Join(";", readerItem.Fields.Select(e => e + ":" + readerItem[e])));
		
	Console.WriteLine("End read data");
}
```

## Support
If you have any questions, problems or suggestions, create an issue.
