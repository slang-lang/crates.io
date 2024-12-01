
import System.Collections.Vector;

public object TModulesRecord {
   public string Added;
   public string Description;
   public string LastUpdate;
   public string Name;
   public string Version;

    public void Constructor( int databaseHandle ) {
        DB = databaseHandle;
    }

    public void Constructor( int databaseHandle, string query ) {
        DB = databaseHandle;

        loadByQuery( query );
    }

    public void Constructor( int databaseHandle, int result ) {
        DB = databaseHandle;

        loadByResult( result );
    }

    public void insert() modify throws {
        var query = "INSERT INTO modules ( `added`, `description`, `last_update`, `name`, `version` ) VALUES ( NULLIF('" + Added + "', ''), '" + Description + "', NULLIF('" + LastUpdate + "', ''), '" + Name + "', '" + Version + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void insertIgnore() modify throws {
        var query = "INSERT IGNORE INTO modules ( `added`, `description`, `last_update`, `name`, `version` ) VALUES ( NULLIF('" + Added + "', ''), '" + Description + "', NULLIF('" + LastUpdate + "', ''), '" + Name + "', '" + Version + "' )";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }


    public void insertOrUpdate() modify throws {
        var query = "INSERT INTO modules ( `added`, `description`, `last_update`, `name`, `version` ) VALUES ( NULLIF('" + Added + "', ''), '" + Description + "', NULLIF('" + LastUpdate + "', ''), '" + Name + "', '" + Version + "' ) ON DUPLICATE KEY UPDATE `added` = NULLIF('" + Added + "', ''), `description` = '" + Description + "', `last_update` = NULLIF('" + LastUpdate + "', ''), `name` = '" + Name + "', `version` = '" + Version + "'";

        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }
    }

    public void loadByQuery( string query ) modify throws {
        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        var result = mysql_store_result( DB );
        if ( !mysql_fetch_row( result ) ) {
            throw "no result found";
        }

       Added = cast<string>( mysql_get_field_value( result, "added" ) );
       Description = cast<string>( mysql_get_field_value( result, "description" ) );
       LastUpdate = cast<string>( mysql_get_field_value( result, "last_update" ) );
       Name = cast<string>( mysql_get_field_value( result, "name" ) );
       Version = cast<string>( mysql_get_field_value( result, "version" ) );
    }

    public void loadByResult( int result ) modify {
       Added = cast<string>( mysql_get_field_value( result, "added" ) );
       Description = cast<string>( mysql_get_field_value( result, "description" ) );
       LastUpdate = cast<string>( mysql_get_field_value( result, "last_update" ) );
       Name = cast<string>( mysql_get_field_value( result, "name" ) );
       Version = cast<string>( mysql_get_field_value( result, "version" ) );
    }

    public string =operator( string ) const {
        return "TModulesRecord { NULLIF('" + Added + "', ''), '" + Description + "', NULLIF('" + LastUpdate + "', ''), '" + Name + "', '" + Version + "' }";
    }

    private int DB const;
}


public object TModulesCollection implements ICollection /*<TModulesRecord>*/ {
    public void Constructor( int databaseHandle, string query = "" ) {
        Collection = new Vector<TModulesRecord>();
        DB = databaseHandle;

        if ( query ) {
            loadByQuery( query );
        }
    }

    public TModulesRecord at( int index ) const throws {
        return Collection.at( index );
    }

    public bool empty() const {
        return Collection.empty();
    }

    public TModulesRecord first() const {
        return Collection.first();
    }

    public Iterator<TModulesRecord> getIterator() const {
        return Collection.getIterator();
    }

    public TModulesRecord last() const {
        return Collection.last();
    }

    public void loadByQuery( string query ) modify throws {
        var error = mysql_query( DB, query );
        if ( error ) {
            throw mysql_error( DB );
        }

        Collection.clear();

        var result = mysql_store_result( DB );
        while ( mysql_fetch_row( result ) ) {
            var record = new TModulesRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void loadByResult( int result ) modify throws {
        Collection.clear();

        while ( mysql_fetch_row( result ) ) {
            var record = new TModulesRecord( DB );
            record.loadByResult( result );

            Collection.push_back( record );
        }
    }

    public void pop_back() modify {
        Collection.pop_back();
    }

    public void pop_front() modify {
        Collection.pop_front();
    }

    public int size() const {
        return Collection.size();
    }

    public void push_back( TModulesRecord item ) modify {
        Collection.push_back( item );
    }

    private Vector<TModulesRecord> Collection;
    private int DB const;
}

