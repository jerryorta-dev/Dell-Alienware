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
    import com.dpa.utils.regexp.createEmailRegExpPattern;
    import com.dpa.utils.regexp.pushRegExpResultsIntoArray;

    import utils.string.search;

    /**
     * Validate a string as a valid email address.
     */
    public function isValidEmailAddress(str:String, notContain:String = null):Boolean
    {
        var result:Array = pushRegExpResultsIntoArray(str,  createEmailRegExpPattern());

        if (notContain != null && result[0] != null) {
            var pattern:RegExp = new RegExp(notContain, "i");
            if (pattern.test(result[0])) {
               return false;
            }
        }

        if (result[0] == null) {
            return false;
        }
        return true;
    }

}
