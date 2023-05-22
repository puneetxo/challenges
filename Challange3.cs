//We have a nested object. We would like a function where you pass in the object and a key and
//get back the value.
//The choice of language and implementation is up to you.

using System;
using System.Collections.Generic;

public static class NestedObjectHelper
{
    public static object GetNestedObjectValue(object obj, string key)
    {
        string[] keys = key.Split('/');

        object value = obj;
        foreach (string k in keys)
        {
            if (value is not IDictionary<string, object> && value is not IDictionary<object, object>)
            {
                throw new InvalidOperationException("Invalid object type encountered.");
            }

            if (!((IDictionary<string, object>)value).ContainsKey(k))
            {
                throw new KeyNotFoundException($"Key '{k}' not found in the object.");
            }

            value = ((IDictionary<string, object>)value)[k];
        }

        return value;
    }
}

public class Program
{
    public static void Main()
    {
        // Example 1
        var object1 = new Dictionary<string, object>
        {
            ["a"] = new Dictionary<string, object>
            {
                ["b"] = new Dictionary<string, object>
                {
                    ["c"] = "d"
                }
            }
        };

        var value1 = NestedObjectHelper.GetNestedObjectValue(object1, "a/b/c");
        Console.WriteLine("Value 1: " + value1);

        // Example 2
        var object2 = new Dictionary<string, object>
        {
            ["x"] = new Dictionary<string, object>
            {
                ["y"] = new Dictionary<string, object>
                {
                    ["z"] = "a"
                }
            }
        };

        var value2 = NestedObjectHelper.GetNestedObjectValue(object2, "x/y/z");
        Console.WriteLine("Value 2: " + value2);
    }
}
