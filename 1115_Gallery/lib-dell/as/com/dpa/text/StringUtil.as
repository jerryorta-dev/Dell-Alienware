/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com
 *
 * Date: 10/30/12
 * Time: 5:15 PM
 */
package com.dpa.text
{
    import flash.utils.getQualifiedClassName;

    public class StringUtil
    {
        public function StringUtil()
        {
        }

        public static function getClassName(o:*):String {
            var fullClassName:String = getQualifiedClassName(o);
            return fullClassName.slice(fullClassName.lastIndexOf("::") + 2);
        }
    }
}
