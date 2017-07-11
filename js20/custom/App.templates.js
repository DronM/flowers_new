/* Copyright (c) 2017
	Andrey Mikhalevich, Katren ltd.

This file is created automaticaly during build process
DO NOT MODIFY IT!!!	
*/
		App.prototype.m_templates = {"GridCmdContainerAjx":`<div id="{{id}}">
	<div id="{{id}}:insert"></div>	
	<div class="btn-group">
		<div id="{{id}}:search:set"></div>
		<div id="{{id}}:search:unset"></div>
	</div>
	
	<div id="{{id}}:filter" class="hidden"></div>
	
	<div id="{{id}}:printObj" class="hidden"></div>
		
	<div id="{{id}}:allCommands"></div>
</div>
`,"ViewGridColManager":`<div id="{{id}}">
	<h1 class="page-header">{{this.HEADER}}</h1>
	
	<ul class="nav nav-tabs" role="tablist">
	    <li role="presentation" class="active"><a href="#columns" aria-controls="columns" role="tab" data-toggle="tab">{{this.TAB_COLUMNS}}</a></li>
	    <li role="presentation"><a href="#sortings" aria-controls="sortings" role="tab" data-toggle="tab">{{this.TAB_SORT}}</a></li>
	</ul>

	<!-- Tab panes -->
	<div class="tab-content">	
		<div role="tabpanel" class="tab-pane active" id="columns">
			<div class="panel panel-body">
				<div id="{{id}}:view-visibility"></div>
			</div>
		</div>

		<div role="tabpanel" class="tab-pane" id="sortings">
			<div class="panel panel-body">
				<div id="{{id}}:view-order"></div>
			</div>
		</div>

		<div role="tabpanel" class="tab-pane" id="filters">
			<div class="panel panel-body">
				<div id="{{id}}:view-filter"></div>
			</div>
		</div>

	<div id="{{id}}:cmdClose"></div>
</div>

`,"PopOver":`<div id="{{id}}" class="popover" role="tooltip" style="position:absolute;display:block;max-width:100%;">
	<div class="tooltip-arrow"></div>
	<h3 id="{{id}}:title" class="popover-title"></h3>
	<div id="{{id}}:content" class="popover-content"></div>
</div>
`,"GridCmdFilterView":`<form id="{{id}}" class="form-horizontal">
	<div class="form-group col-lg-12">
		<div id="{{id}}:set"></div>
		<div id="{{id}}:unset"></div>
		<div id="{{id}}:save"></div>
		<div id="{{id}}:open"></div>
	</div>
</form>
`,"EditPeriodDate":`<div id="{{id}}" class="form-group col-lg-12">
	<a class="{{window.getBsCol(1)}}" id="{{id}}:periodSelect"></a>	
	<div class="btn-group {{window.getBsCol(2)}}">
		<div id="{{id}}:downFast" title="{{this.CONTR_DOWN_FAST_TITLE}}"></div>
		<div id="{{id}}:down" title="{{this.CONTR_DOWN_TITLE}}"></div>
	</div>
	
	<div id="{{id}}:d-cont" class="{{window.getBsCol(7)}}" style="padding-right:0px;padding-left:0px;">
		<div id="{{id}}:from" class="{{window.getBsCol(6)}}" style="padding:0px 0px;margin:0px 0px;"></div>
		<!--<span class="{{window.getBsCol(1)}}" style="padding-left:0px;padding-right:0px">-</span>-->
		<div id="{{id}}:to" class="{{window.getBsCol(6)}}" style="padding:0px 0px;margin:0px 0px;"></div>	
	</div>
	
	<div class="btn-group {{window.getBsCol(2)}}">
		<div id="{{id}}:upFast" title="{{this.CONTR_UP_FAST_TITLE}}"></div>
		<div id="{{id}}:up" title="{{this.CONTR_UP_TITLE}}"></div>
	</div>
	
</div>
`,"WindowPrint":`<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<meta http-equiv="content-type" content="text/html; charset=UTF-8">
		<link rel="stylesheet" href="js20/custom-css/print.css?'+{{CommonHelper.uniqid()}}+'" type="text/css" media="all">
		<title>{{options.title}}</title>
	</head>
	<body>{{options.content}}</h1></body>
</html>

`,"VariantStorageSaveView":`<div id="{{id}}">
	<div id="{{id}}:variants"></div>
	<div id="{{id}}:name"></div>
	<div id="{{id}}:default_variant"></div>
	<div id="{{id}}:cmdSave"></div>
	<div id="{{id}}:cmdCancel"></div>
</div>
`,"VariantStorageOpenView":`<div id="{{id}}">
	<div id="{{id}}:variants"></div>
	<div id="{{id}}:cmdOpen"></div>
	<div id="{{id}}:cmdCancel"></div>
</div>
`,"DOCClientOrderGridCommand":`<div id="{{id}}">
	<div>
		<div id="{{id}}:insert"></div>	
		<div class="btn-group">
			<div id="{{id}}:search:set"></div>
			<div id="{{id}}:search:unset"></div>
		</div>
	
		<div id="{{id}}:filter" class="hidden"></div>
		
		<div id="{{id}}:printObj" class="hidden"></div>
		
		<div id="{{id}}:allCommands"></div>
	</div>
	<div>
		<div id="{{id}}:cmdStatChecked"></div>
		<div id="{{id}}:cmdStatToFlorist"></div>
		<div id="{{id}}:cmdStatToCourier"></div>
		<div id="{{id}}:cmdStatClosed"></div>
		<div id="{{id}}:cmdStatPayed"></div>
	</div>
</div>
`}