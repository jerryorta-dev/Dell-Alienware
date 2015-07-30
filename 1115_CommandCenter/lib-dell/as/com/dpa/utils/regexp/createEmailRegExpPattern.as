/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/9/12
 * Time: 4:15 PM
 *
 */
package com.dpa.utils.regexp {
    public function createEmailRegExpPattern():RegExp {
        var pattern:RegExp = /\b[\w\.-]+@[\w\.-]+\.\w{2,4}\b/gixsm;
        return pattern;
    }
}
