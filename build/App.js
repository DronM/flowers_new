/* Copyright (c) 2016 
	Andrey Mikhalevich, Katren ltd.
*/
/*	
	Description
*/
/** Requirements
 * @requires controls/WindowMessage.js
 * @requires core/ConstantManager.js 
*/

/* constructor
@param string id,
@param object options{
	@param string host
	@param string bsCol
	@param object servVars
	@param string constantXMLString XML data for model
	@param string lang
}
*/
function App(id,options){
	options = options || {};	
	
	var self = this;
	window.onerror = function(msg,url,line,col,error){
		self.onError(msg,url,line,col,error);
	};

	this.setHost(options.host);
	this.setScript(options.script);
	//this.setBsCol(options.bsCol);
	this.m_servVars = options.servVars;
	this.setLang(options.lang);
	
	this.setServConnection(new ServConnector(options.host));
	
	this.m_constantManager = new ConstantManager(this.m_servConnection,{"XMLString":options.constantXMLString});
	
	this.m_cashData = {};
	this.m_openedForms = {};
	
	if (options.error){
		throw Error(options.error);
	}
}

/* Constants */

App.prototype.DEF_dateEditMask = "99/99/9999";
App.prototype.DEF_dateFormat = "d/m/Y";

App.prototype.DEF_dateTimeEditMask = "99/99/9999 99:99:99";
App.prototype.DEF_dateTimeFormat = "d/m/Y H:i:s";

App.prototype.DEF_phoneEditMask = "+7-(999)-999-99-99";
App.prototype.DEF_timeEditMask = "99:99";
App.prototype.DEF_timeFormat = "H:i:s";

/* private members */
App.prototype.m_host;
App.prototype.m_script;
App.prototype.m_bsCol;
App.prototype.m_winClass;
App.prototype.m_servVars;
App.prototype.m_constantManager;
App.prototype.m_servConnection;
App.prototype.m_dateEditMask;
App.prototype.m_dateFormat;
App.prototype.m_dateTimeEditMask;
App.prototype.m_dateTimeFormat;
App.prototype.m_timeFormat;

App.prototype.m_phoneEditMask;
App.prototype.m_timeEditMask;

App.prototype.m_lang;
App.prototype.m_cashData;

App.prototype.m_openedForms;

/* protected*/


/* public methods */
App.prototype.setHost = function(host){
	this.m_host = host;
}

App.prototype.getHost = function(){
	return this.m_host;
}

App.prototype.setScript = function(v){
	this.m_script = v;
}

App.prototype.getScript = function(){
	return this.m_script;
}
/*
App.prototype.setBsCol = function(bsCol){
	this.m_bsCol = bsCol;
}
*/
App.prototype.getBsCol = function(v){
	return window.getBsCol(v);
	//return  this.m_bsCol+((v!=undefined)? v.toString():"");
}

App.prototype.setWinClass = function(winClass){
	this.m_winClass = winClass;
}

App.prototype.getWinClass = function(winClass){
	return this.m_winClass;
}

App.prototype.getServVars = function(){
	return this.m_servVars;
}

App.prototype.getServVar = function(id){
	return this.m_servVars[id];
}

App.prototype.getConstantManager = function(){
	return this.m_constantManager;
}

/*
App.prototype.readConstants = function(){
	if (!CommonHelper.isEmpty()){
		var contr = new Constant_Controller(new ServConnector(this.m_host));
		contr.readValues(this.m_constants);
	
	}
}
*/

App.prototype.onError = function(msg,url,line,col,error) {
	var str = msg + "\nurl: " + url + "\nline: " + line;
	console.log(str);
	console.trace();
		
	this.showError(str);
	
	return false;
}

App.prototype.showMsg = function(msgType,msg,callBack,timeout) {
	WindowMessage.show({
		"type":msgType,
		"text":msg,
		"callBack":callBack,
		"timeout":timeout,
		"bsCol":this.m_bsCol
	});	
}

App.prototype.resetError = function() {
}

App.prototype.showError = function(msg,callBack,timeout) {
	this.showMsg(WindowMessage.TP_ER,msg,callBack,timeout);
}
App.prototype.showWarn = function(msg,callBack,timeout) {
	this.showMsg(WindowMessage.TP_WARN,msg,callBack,timeout);
}
App.prototype.showNote = function(msg,callBack,timeout) {
	this.showMsg(WindowMessage.TP_NOTE,msg,callBack,timeout);
}
App.prototype.showOk = function(msg,callBack,timeout) {
	this.showMsg(WindowMessage.TP_OK,msg,callBack,timeout);
}

App.prototype.setGlobalWait = function(isWait){
	var n = CommonHelper.nd("waiting");	
	if (n&&isWait){		
		CommonHelper.delClass(n,"hidden");
	}
	else if (n){
		CommonHelper.addClass(n,"hidden");
	}
}

App.prototype.getServConnection = function(){
	return this.m_servConnection;
}

App.prototype.setServConnection = function(v){
	this.m_servConnection = v;
}

/**/
App.prototype.setDateEditMask = function(v){
	this.m_dateEditMask = v;
}
App.prototype.getDateEditMask = function(){
	return (this.m_dateEditMask)? this.m_dateEditMask : this.DEF_dateEditMask;
}

App.prototype.setDateTimeEditMask = function(v){
	this.m_dateTimeEditMask = v;
}
App.prototype.getDateTimeEditMask = function(){
	return (this.m_dateTimeEditMask)? this.m_dateTimeEditMask : this.DEF_dateTimeEditMask;
}

App.prototype.setDateFormat = function(v){
	this.m_dateFormat = v;
}
App.prototype.getDateFormat = function(){
	return (this.m_dateFormat)? this.m_dateFormat : this.DEF_dateFormat;
}

App.prototype.setDateTimeFormat = function(v){
	this.m_dateTimeFormat = v;
}
App.prototype.getDateTimeFormat = function(){
	return (this.m_dateTimeFormat)? this.m_dateTimeFormat : this.DEF_dateTimeFormat;
}

App.prototype.setTimeFormat = function(v){
	this.m_timeFormat = v;
}
App.prototype.getTimeFormat = function(){
	return (this.m_timeFormat)? this.m_timeFormat : this.DEF_timeFormat;
}

App.prototype.setPhoneEditMask = function(v){
	this.m_phoneEditMask = v;
}
App.prototype.getPhoneEditMask = function(){
	return (this.m_phoneEditMask)? this.m_phoneEditMask : this.DEF_phoneEditMask;
}
App.prototype.setTimeEditMask = function(v){
	this.m_timeEditMask = v;
}
App.prototype.getTimeEditMask = function(){
	return (this.m_timeEditMask)? this.m_timeEditMask : this.DEF_timeEditMask;
}

App.prototype.setLang = function(v){
	this.m_lang = v;
}
App.prototype.getLang = function(){
	return this.m_lang;
}

App.prototype.formatError = function(erCode,erStr){
	return (erStr + (erCode)? (", code:"+erCode):"");
}

App.prototype.getCashData = function(id){
	return this.m_cashData[id];
}
App.prototype.setCashData = function(id,val){
	this.m_cashData[id] = val;
}

App.prototype.getOpenedForms = function(){
	return this.m_openedForms;
}

App.prototype.addOpenedForm = function(id,form){
	this.m_openedForms[id] = form;
}
App.prototype.delOpenedForm = function(id){
	delete this.m_openedForms[id];
}

