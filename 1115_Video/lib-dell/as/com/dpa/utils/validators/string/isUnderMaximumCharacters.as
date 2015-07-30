/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 12/2/12
 * Time: 2:47 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.utils.validators.string {
    public function isUnderMaximumCharacters(text:String, value:Number):Boolean {
        if (text.length <= value) {
            return true;
        } else {
            return false;
        }
    }

}
