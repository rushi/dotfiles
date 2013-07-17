;(function () {

  /**
   *  * Make all queries pretty print by default.
   *   */

  DBQuery.prototype._prettyShell = true

  /**
   *  * Allow opting into the default ugly print mode.
   *   */

  DBQuery.prototype.ugly = function () {
      this._prettyShell = false;
        return this
  }
})();
