;(function () {

    /*
     * Make all queries pretty by default
     */
    DBQuery.prototype._prettyShell = true

    /*
     * Allow opting into the default ugly mode
     */
    DBQuery.prototype.ugly = function () {
        this._prettyShell = false;
        return this
    }
   
    /*
     * Quick short cut for db.getCollectionNames() because its too long
     */
    DB.prototype.colls = function() {
        return this.getCollectionNames();
    }

    /*
     * New method to return elements in descending order of MongoID. 
     * Essentially to get the last created documents
     */
    DBQuery.prototype.reverse = function() {
        var limitCount = (arguments[0]) ? parseInt(arguments[0]) : 99999;
        return this.sort({_id: -1}).limit(limitCount);
    }

    DBQuery.prototype.asc = function() {
        var limitCount = (arguments[0]) ? parseInt(arguments[0]) : 100;
        return this.sort({_id: 1}).limit(limitCount);
    }

    DBQuery.prototype.desc = function() {
        return this.reverse();
    }

    /*
     * Return the last one record only
     */
    DBQuery.prototype.last = function() {
        return this.reverse(1);
    }

    DBCollection.prototype.findById = function(id) {
        return this.find({ _id : id });
    }
})();
