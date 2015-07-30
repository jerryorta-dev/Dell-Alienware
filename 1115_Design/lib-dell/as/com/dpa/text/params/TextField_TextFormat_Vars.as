/**
 * Created with IntelliJ IDEA.
 * User: jerryorta
 * Date: 11/25/12
 * Time: 4:12 PM
 * To change this template use File | Settings | File Templates.
 */
package com.dpa.text.params {
    import com.dpa.utils.objects.union;

    import flash.text.AntiAliasType;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormatAlign;

    import utils.object.clone;

    public class TextField_TextFormat_Vars {

        private var _vars:Object;
        private var _textFormatVars:TextFormatVars;
        private var _textFieldVars:TextFieldVars;

        public function TextField_TextFormat_Vars(vars:Object = null) {
            _vars = (vars != null) ? clone(vars) : new Object();

            _textFormatVars = new TextFormatVars().align(TextFormatAlign.LEFT).color(0x000000).size(14).leading(2).letterSpacing(0);
            _textFieldVars = new TextFieldVars().antiAliasType(AntiAliasType.ADVANCED).autoSize(TextFieldAutoSize.LEFT).border(false).embedFonts(true).multiline(true).selectable(false).borderColor().wordWrap(true).type(null).height(20);
            _textFieldVars.defaultTextFormat(_textFormatVars.vars);

        }

        public function get vars():Object {
            _vars = union(_vars, _textFieldVars.vars);
            return _vars;
        }

        public function set vars(value:Object):void {
            _vars = value;
        }

        public function get textFieldVars():TextFieldVars {
            return _textFieldVars;
        }

        public function set textFieldVars(value:TextFieldVars):void {
            _textFieldVars = value;
        }

        public function get textFormatVars():TextFormatVars {
            return _textFormatVars;
        }

        public function set textFormatVars(value:TextFormatVars):void {
            _textFormatVars = value;
        }
    }
}
