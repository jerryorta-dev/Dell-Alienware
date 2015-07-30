/**
 * Created with IntelliJ IDEA.
 * User: Jerry Orta
 * http://www.digitalproductionart.com
 * jerryorta@gmail.com
 *
 * Date: 12/2/12
 * Time: 9:24 AM
 */
package com.dpa.utils.validators.string
{
   public function isOverMinimumCharacters(text:String, value:int):Boolean
    {
        if (text.length >= value) {
            return true;
        } else {
            return false;
        }
    }

}
