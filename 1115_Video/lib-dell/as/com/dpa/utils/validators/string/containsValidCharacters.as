/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/9/12
 * Time: 9:29 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.validators.string {
    public function containsValidCharacters(str:String,  regExp:RegExp):Boolean {
        var result:String =  str.replace(regExp, "");

        if (result == "") {
            return true
        }

        return false;
    }
}
