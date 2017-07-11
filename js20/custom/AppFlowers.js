/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires core/extend.js
 * @requires core/App.js
*/

/* constructor */
function AppFlowers(options){
	options = options || {};
	
	this.setCachRegister(options.cashRegister);
	
	AppFlowers.superclass.constructor.call(this,"Flowers",options);

}
extend(AppFlowers,App);

/* Constants */

/* private members */
AppFlowers.prototype.m_cashRegister;

/* protected*/


/* public methods */
AppFlowers.prototype.formatError = function(erCode,erStr){
	return (erStr +( (erCode)? (", код:"+erCode):"" ) );
}
AppFlowers.prototype.getJournalDateFormat = function(){
	return "d/m/y, H:i:s";
}

AppFlowers.prototype.setCachRegister = function(v){
	this.m_cashRegister = v;
}

AppFlowers.prototype.getCachRegister = function(){
	return this.m_cashRegister;
}

AppFlowers.prototype.getCachierPwd = function(){
	return "29";
}
AppFlowers.prototype.getCachierAdminPwd = function(){
	return "30";
}
AppFlowers.prototype.getCachierSalePwd = function(){
	return "1";
}

