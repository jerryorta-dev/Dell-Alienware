/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/9/12
 * Time: 9:29 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.validators.string {
    public function returnInvalidCharacters(str:String,  regExp:RegExp):String {
        var result:String =  str.replace(regExp, "");
        return result;
    }
}
