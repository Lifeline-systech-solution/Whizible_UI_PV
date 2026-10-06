using Newtonsoft.Json.Linq;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web.Http;
using System.Security.Authentication;
using System.Web;
using System.Runtime.Caching;

public static class MemoryCacher

{

    public static object GetValue(string key)

    {

        MemoryCache memoryCache = MemoryCache.Default;

        return memoryCache.Get(key);

    }


    public static bool Add(string key, object value, DateTimeOffset absExpiration)

    {

        MemoryCache memoryCache = MemoryCache.Default;

        return memoryCache.Add(key, value, absExpiration);

    }


    public static void Delete(string key)

    {

        MemoryCache memoryCache = MemoryCache.Default;

        if (memoryCache.Contains(key))

        {

            memoryCache.Remove(key);

        }

    }
    public static bool Contains(string key)

    {

        MemoryCache memoryCache = MemoryCache.Default;

        if (memoryCache.Contains(key))

        {

            return true;

        }
        return false;
    }

}

