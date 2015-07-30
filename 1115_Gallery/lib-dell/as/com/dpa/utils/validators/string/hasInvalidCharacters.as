/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/9/12
 * Time: 7:58 AM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.validators.string {
    public function hasInvalidCharacters(str:String, regExp:RegExp = null):Boolean
{
    var testExp:RegExp;
    if (regExp != null) {
        testExp = regExp;
    } else {
        testExp = /[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/gixsm;
    }


    return testExp.test(str);
}
}
