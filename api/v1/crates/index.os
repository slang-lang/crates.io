#!/usr/local/bin/webscript

// library imports

// project imports
import libs.API.Utils;
import libs.Database.Tables.Modules;
import libs.MainProcessJsonDB;


public void Process( int, string )
{
    var name = API.retrieve( "q", "" );
    var page = API.retrieve( "page", 1 );
    var perPage = API.retrieve( "per_page", 10 );

    if ( name ) {
        retrieveSingleModule( name, page, perPage );
    }
    else {
        retrieveAllModules( page, perPage );
    }
}

private void retrieveAllModules( int page, int perPage ) throws
{
    var query = "SELECT * FROM modules GROUP BY name ORDER BY name ASC, version DESC LIMIT " + ( page - 1 ) * perPage + ", " + perPage;
    var collection = new TModulesCollection( Database.Handle, query );

    Json.BeginArray( "crates" );
    foreach ( TModulesRecord record : collection ) {
        Json.BeginObject();
            Json.AddElement( "id", record.Name );
            Json.AddElement( "name", record.Name );
            Json.AddElement( "updated_at", record.LastUpdate );
            Json.AddElement( "versions", "null" );
            Json.AddElement( "keywords", "null" );
            Json.AddElement( "categories", "null" );
            Json.AddElement( "badges", "[]" );
            Json.AddElement( "created_at", record.Added );
            Json.AddElement( "downloads", "0" );
            Json.AddElement( "recent_downloads", "0" );
            Json.AddElement( "default_version", record.Version );
            Json.AddElement( "yanked", "false" );
            Json.AddElement( "max_version", record.Version );
            Json.AddElement( "newest_version", record.Version );
            Json.AddElement( "max_stable_version", record.Version );
            Json.AddElement( "description", record.Description );
            Json.AddElement( "homepage", "https://slang-lang.org" );
            Json.AddElement( "documentation", "null" );
            Json.AddElement( "repository", "null" );
            Json.AddElement( "exact_match", "false" );
        Json.EndObject();
    }
    Json.EndArray();

    Json.BeginObject( "meta" );
        Json.AddElement( "total", 1 );
        Json.AddElement( "next_page", "null" );
        Json.AddElement( "prev_page", "null" );
    Json.EndObject();
}

private void retrieveSingleModule( string name, int page, int perPage ) throws
{
    var query = "SELECT * FROM modules WHERE name LIKE '%" + name + "%' GROUP BY name ORDER BY name ASC, version DESC LIMIT " + ( page - 1 ) * perPage + ", " + perPage;
    var collection = new TModulesCollection( Database.Handle, query );

    Json.BeginArray( "crates" );
    foreach ( TModulesRecord record : collection ) {
        Json.BeginObject();
            Json.AddElement( "id", record.Name );
            Json.AddElement( "name", record.Name );
            Json.AddElement( "updated_at", record.LastUpdate );
            Json.AddElement( "versions", "null" );
            Json.AddElement( "keywords", "null" );
            Json.AddElement( "categories", "null" );
            Json.AddElement( "badges", "[]" );
            Json.AddElement( "created_at", record.Added );
            Json.AddElement( "downloads", "0" );
            Json.AddElement( "recent_downloads", "0" );
            Json.AddElement( "default_version", record.Version );
            Json.AddElement( "yanked", "false" );
            Json.AddElement( "max_version", record.Version );
            Json.AddElement( "newest_version", record.Version );
            Json.AddElement( "max_stable_version", record.Version );
            Json.AddElement( "description", record.Description );
            Json.AddElement( "homepage", "https://slang-lang.org" );
            Json.AddElement( "documentation", "https://slang-lang.org" );
            Json.AddElement( "repository", "https://slang-lang.org/repo/stable" );
            Json.AddElement( "exact_match", "false" );
        Json.EndObject();
    }
    Json.EndArray();

    Json.BeginObject( "meta" );
        Json.AddElement( "total", collection.size() );
        Json.AddElement( "next_page", "null" );
        Json.AddElement( "prev_page", "null" );
    Json.EndObject();
}

