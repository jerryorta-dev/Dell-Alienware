/**
 * VERSION:
 * AS3
 *
 * Created with IntelliJ IDEA.
 * User: jerry.orta
 * http://www.digitalproductionart.com
 *
 * Date: 10/30/12
 * Time: 8:49 AM
 */
package com.dpa.utils.objects
{
    import utils.type.getClassName;
    import flash.utils.describeType;

        /**
         * Combine the properties of two objects into one object. For example, varsA union varsB will add
         * the properties of varsB to varsA. If both objects have an identical property, the property of
         * varsB will overwrite the identical property for varsA.
         *
         * usage:
         * var objC:Object = ObjectProperties.union(objA, objB);
         *
         * @param varsA
         * @param varsB
         * @return
         */
        public function union(defaultVars:Object, additionalVars:Object):Object {
           /*
            if (defaultVars == null && additionalVars != null) {
                return additionalVars;
            }

            if (defaultVars != null && additionalVars == null) {
                return defaultVars;
            }

            if (defaultVars != null && additionalVars != null) {
                for (var p:String in additionalVars) {
                    defaultVars[p] = additionalVars[p];
                }
            }

            return defaultVars;
            */

            var combinedObject:Object = {};
            var property:String;

            //Return additionalVars if defaultVars is null
            if (defaultVars == null && additionalVars != null) {
                for (property in additionalVars) {
                    combinedObject[property] = additionalVars[property];
                }

            }

            //return defaultVars if additionalVars is null
            if (defaultVars != null && additionalVars == null) {
                for (property in defaultVars) {
                    combinedObject[property] = defaultVars[property];
                }
            }

            //union if both are not null
            if (defaultVars != null && additionalVars != null) {
                for (property in defaultVars)
                {
                    combinedObject[property] = defaultVars[property];
                }

                for (property in additionalVars)
                {
                    if (getClassName(additionalVars[property]) == "Object") {
//                        var subObject:Object = {};
                        combinedObject[property] = union(combinedObject[property], additionalVars[property]);
                    } else {
                        combinedObject[property] = additionalVars[property];
                    }

                }
            }

            return combinedObject;
        }



}
