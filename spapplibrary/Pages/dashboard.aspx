<%-- The following 4 lines are ASP.NET directives needed when using SharePoint components --%>

<%@ Page Inherits="Microsoft.SharePoint.WebPartPages.WebPartPage, Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" MasterPageFile="../_catalogs/masterpage/MasterPageGallery/people.master" Language="C#" %>

<%@ Register TagPrefix="Utilities" Namespace="Microsoft.SharePoint.Utilities" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="WebPartPages" Namespace="Microsoft.SharePoint.WebPartPages" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>
<%@ Register TagPrefix="SharePoint" Namespace="Microsoft.SharePoint.WebControls" Assembly="Microsoft.SharePoint, Version=15.0.0.0, Culture=neutral, PublicKeyToken=71e9bce111e9429c" %>

<%-- The markup and script in the following Content element will be placed in the <head> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderAdditionalPageHead" runat="server">
    <%--<script type="text/javascript" src="../Scripts/jquery-1.9.1.min.js"></script>--%>

    <script type="text/javascript" src="../_layouts/15/sp.runtime.js"></script>
    <script type="text/javascript" src="../_layouts/15/sp.js"></script>
    <meta name="WebPartPageExpansion" content="full" />
</asp:Content>

<%-- The markup in the following Content element will be placed in the TitleArea of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderPageTitleInTitleArea" runat="server">
    Application Dashboard
</asp:Content>

<%-- The markup and script in the following Content element will be placed in the <body> of the page --%>
<asp:Content ContentPlaceHolderID="PlaceHolderMain" runat="server">
        <SharePoint:ScriptLink language="javascript" name="SP.js" defer="true" runat="server" Localizable="false"/>
   
                                                  
<div id="dashboard_tabs" class="col-xs-12 col-sm-12">
    <div>
        <input type="button" style="padding: 2px;margin: 15px 0;" class="btn btn-primary" onclick="issueBook();" value="Issue Book"/>
        <input type="button" style="padding: 2px;margin: 15px 0;" class="btn btn-primary" onclick="addBook();" value="Add Book"/>
    </div>




		<!--Start Dashboard Tab 1-->
		<div id="dashboard-overview" class="row" style="visibility: visible; position: relative;">
			<div id="ow-marketplace1" class="col-sm-12 col-md-6" data-bind="" >
				
				<h4 class="page-header">Issued Books</h4>

                    <div>
                        
                        <div>
                            <div class="input-group input-group-lg">Book Title - <input data-bind="value: tempbookTitle, valueUpdate: 'keyup'" value=""/></div>
                            <div class="input-group input-group-lg">Issued To User Email - <input data-bind="value: tempbookIssuedToUser, valueUpdate: 'keyup'" value=""/></div>
                            <div class="input-group input-group-lg">Book Issue Date<input id="bookIssue" data-bind="value: tempbookIssueDate, valueUpdate: 'keyup'" value=""/></div>
                            <div class="input-group input-group-lg">Book Return Date<input id="bookReturn" data-bind="value: tempbookReturnDate, valueUpdate: 'keyup'" value=""/></div>
                            <div class="input-group input-group-lg"><span class="btn btn-primary" data-bind="click: issueNewBookSP">Issue Book To People</span></div>
                        </div>
                    </div>

				<table id="ticker-table" class="table m-table table-bordered table-hover table-heading">
					<thead>
						<tr>
							<th>Title</th>
							<th>Issued To User</th>
							<th>Issue Date</th>
                            <th>Issue Return Date</th>
						</tr>
					</thead>
					<tbody <%--id="issuedElement"--%> data-bind="template: { name: 'BooksIssuedTemplate', foreach: issueList }">
						
						
					</tbody>
				</table>
			</div>

<div id="ow-marketplace2" class="col-sm-12 col-md-6">
				
				<h4 class="page-header">All Books List</h4>
				<table id="Table1" class="table m-table table-bordered table-hover table-heading">
					<thead>
						<tr>
							<th>Title</th>
							<th>Author</th>
							<th>Quantity</th>
                            <th>Ratings</th>
						</tr>
					</thead>
					<tbody <%--id="booksElement"--%> data-bind="template: { name: 'BooksListTemplate', foreach: bookList }">
						
						
					</tbody>
				</table>
			</div>




		<%--	<div class="col-xs-12 col-md-6">
				
				<div id="ow-activity" class="row">
					<div class="col-xs-2 col-sm-1 col-md-2">
						<div class="v-txt">ACTIVITY</div>
					</div>
					<div class="col-xs-7 col-sm-5 col-md-6">
						<div class="row"><i class="fa fa-code"></i> Release published <span class="label label-default pull-right">01:17:34</span></div>
						<div class="row"><i class="fa fa-cloud-upload"></i> Backup created <span class="label label-default pull-right">03:23:34</span></div>
						<div class="row"><i class="fa fa-camera"></i> Snapshot created <span class="label label-default pull-right">04:22:11</span></div>
						<div class="row"><i class="fa fa fa-money"></i> Invoice pay <span class="label label-default pull-right">05:11:51</span></div>
						<div class="row"><i class="fa fa-briefcase"></i> Project edited <span class="label label-default pull-right">04:52:23</span></div>
						<div class="row"><i class="fa fa-floppy-o"></i> Project saved <span class="label label-default pull-right">07:11:01</span></div>
						<div class="row"><i class="fa fa-bug"></i> Bug fixed <span class="label label-default pull-right">09:10:31</span></div>
					</div>
					<div id="ow-stat" class="col-xs-3 col-sm-4 col-md-4 pull-right">
						<div class="row"><small><b>Ow Stat.:</b></small></div>
						<div class="row">%user <sup>20,43</sup></div>
						<div class="row">%nice <sup>1,01</sup></div>
						<div class="row">%system <sup>27,34</sup></div>
						<div class="row">%iowait <sup>2,02</sup></div>
						<div class="row">%steal <sup>1,22</sup></div>
						<div class="row">%idle <sup>47,98</sup></div>
						<div class="row">tps <sup>296546</sup></div>
					</div>
				</div>
				<div id="ow-summary" class="row">
					<div class="col-xs-12">
						<h4 class="page-header">Σ SUMMARY</h4>
						<div class="row">
							<div class="col-xs-12">
								<div class="row">
									<div class="col-xs-6">Total commits<b>1245634</b></div>
									<div class="col-xs-6">Release count<b>227</b></div>
								</div>
								<div class="row">
									<div class="col-xs-6">Tests passed<b>5222345</b></div>
									<div class="col-xs-6">Tickets solved<b>324322</b></div>
								</div>
								<div class="row">
									<div class="col-xs-6">Active clients<b>52145</b></div>
									<div class="col-xs-6">Support team<b>288</b></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>--%>
		</div>
		<!--End Dashboard Tab 1-->
		<!--Start Dashboard Tab 2-->
		<%--<div id="dashboard-clients" class="row" style="visibility: hidden; position: absolute;">
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-users"></i></div>
				<div class="col-xs-2"><b>Country</b></div>
				<div class="col-xs-2">Visitors</div>
				<div class="col-xs-2">Page hits</div>
				<div class="col-xs-2">Revenue</div>
				<div class="col-xs-1">Activity</div>
				<div class="col-xs-2">Date</div>
			</div>
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-user"></i></div>
				<div class="col-xs-2"><b>USA</b></div>
				<div class="col-xs-2">109455</div>
				<div class="col-xs-2">54322344</div>
				<div class="col-xs-2"><i class="fa fa-usd"></i> 354563</div>
				<div class="col-xs-1"><span class="bar"><canvas height="30" width="54" style="display: inline-block; vertical-align: top; width: 54px; height: 30px;"></canvas></span></div>
				<div class="col-xs-2 message-date">12/31/13</div>
			</div>
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-user"></i></div>
				<div class="col-xs-2"><b>U.K.</b></div>
				<div class="col-xs-2">86549</div>
				<div class="col-xs-2">43242344</div>
				<div class="col-xs-2"><i class="fa fa-usd"></i> 265563</div>
				<div class="col-xs-1"><span class="bar"><canvas height="30" width="54" style="display: inline-block; vertical-align: top; width: 54px; height: 30px;"></canvas></span></div>
				<div class="col-xs-2 message-date">12/25/13</div>
			</div>
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-user"></i></div>
				<div class="col-xs-2"><b>FRANCE</b></div>
				<div class="col-xs-2">79399</div>
				<div class="col-xs-2">45376844</div>
				<div class="col-xs-2"><i class="fa fa-usd"></i> 309456</div>
				<div class="col-xs-1"><span class="bar"><canvas height="30" width="54" style="display: inline-block; vertical-align: top; width: 54px; height: 30px;"></canvas></span></div>
				<div class="col-xs-2 message-date">12/30/13</div>
			</div>
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-user"></i></div>
				<div class="col-xs-2"><b>GERMANY</b></div>
				<div class="col-xs-2">94567</div>
				<div class="col-xs-2">35322344</div>
				<div class="col-xs-2"><i class="fa fa-usd"></i> 301040</div>
				<div class="col-xs-1"><span class="bar"><canvas height="30" width="54" style="display: inline-block; vertical-align: top; width: 54px; height: 30px;"></canvas></span></div>
				<div class="col-xs-2 message-date">12/26/13</div>
			</div>
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-user"></i></div>
				<div class="col-xs-2"><b>CANADA</b></div>
				<div class="col-xs-2">89525</div>
				<div class="col-xs-2">1342344</div>
				<div class="col-xs-2"><i class="fa fa-usd"></i> 298764</div>
				<div class="col-xs-1"><span class="bar"><canvas height="30" width="54" style="display: inline-block; vertical-align: top; width: 54px; height: 30px;"></canvas></span></div>
				<div class="col-xs-2 message-date">12/30/13</div>
			</div>
			<div class="row one-list-message">
				<div class="col-xs-1"><i class="fa fa-user"></i></div>
				<div class="col-xs-2"><b>CHINA</b></div>
				<div class="col-xs-2">120865</div>
				<div class="col-xs-2">43522344</div>
				<div class="col-xs-2"><i class="fa fa-usd"></i> 776563</div>
				<div class="col-xs-1"><span class="bar"><canvas height="30" width="54" style="display: inline-block; vertical-align: top; width: 54px; height: 30px;"></canvas></span></div>
				<div class="col-xs-2 message-date">12/29/13</div>
			</div>
		</div>--%>
		<!--End Dashboard Tab 2-->
		<!--Start Dashboard Tab 3-->
		<%--<div id="dashboard-graph" class="row" style="width:100%; visibility: hidden; position: absolute;">
			<div class="col-xs-12">
				<h4 class="page-header">OS Platform Statistics</h4>
				<div id="stat-graph" style="height: 300px; position: relative;"><svg style="overflow: hidden; position: relative; left: -0.200012px; top: -0.799988px;" xmlns="http://www.w3.org/2000/svg" width="1000" version="1.1" height="300"><desc>Created with Raphaël 2.1.2</desc><defs></defs><text font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="end" y="260.6000003814697" x="27.699999809265137" style="text-anchor: end; font: 12px sans-serif;"><tspan dy="3.9999914169311523">0</tspan></text><path stroke-width="0.5" d="M40.19999980926514,260.6000003814697H975" stroke="#aaaaaa" fill="none" style=""></path><text font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="end" y="201.7000002861023" x="27.699999809265137" style="text-anchor: end; font: 12px sans-serif;"><tspan dy="4.000000476837158">15</tspan></text><path stroke-width="0.5" d="M40.19999980926514,201.7000002861023H975" stroke="#aaaaaa" fill="none" style=""></path><text font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="end" y="142.80000019073486" x="27.699999809265137" style="text-anchor: end; font: 12px sans-serif;"><tspan dy="3.9999942779541016">30</tspan></text><path stroke-width="0.5" d="M40.19999980926514,142.80000019073486H975" stroke="#aaaaaa" fill="none" style=""></path><text font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="end" y="83.90000009536743" x="27.699999809265137" style="text-anchor: end; font: 12px sans-serif;"><tspan dy="3.999995708465576">45</tspan></text><path stroke-width="0.5" d="M40.19999980926514,83.90000009536743H975" stroke="#aaaaaa" fill="none" style=""></path><text font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="end" y="25" x="27.699999809265137" style="text-anchor: end; font: 12px sans-serif;"><tspan dy="4">60</tspan></text><path stroke-width="0.5" d="M40.19999980926514,25H975" stroke="#aaaaaa" fill="none" style=""></path><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="975" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2014-01</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="895.6060273810609" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-12</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="818.7731506530553" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-11</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="739.3791780341162" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-10</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="662.5463013061105" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-09</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="583.1523286871715" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-08</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="503.75835606823233" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-07</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="426.9254793402267" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-06</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="347.5315067212876" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-05</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="270.698629993282" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-04</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="191.30465737434284" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-03</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="119.59397242820427" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-02</tspan></text><text transform="matrix(1,0,0,1,0,7.2)" font-weight="normal" font-family="sans-serif" font-size="12px" fill="#888888" stroke="none" font="10px &quot;Arial&quot;" text-anchor="middle" y="273.1000003814697" x="40.19999980926514" style="text-anchor: middle; font: 12px sans-serif;"><tspan dy="4.000006675720215">2013-01</tspan></text><path stroke-width="3" d="M40.19999980926514,251.96133370081583C60.04849296399992,251.96133370081583,99.74547927346948,252.01291279694453,119.59397242820427,251.96133370081583C137.52164366473892,251.9147461301189,173.3769861378082,251.56866703351338,191.30465737434284,251.56866703351338C211.15315052907764,251.56866703351338,250.8501368385472,252.11099763548438,270.698629993282,251.96133370081583C289.9068491752834,251.81649763500755,328.3232875392862,250.87345391763364,347.5315067212876,250.39066703160603C367.37999987602234,249.8917872493775,407.07698618549193,248.33399489712843,426.9254793402267,248.03466702779133C446.1336985222281,247.74499489617477,484.5501368862309,248.13122440499686,503.75835606823233,248.03466702779133C523.6068492229671,247.93489107134562,563.3038355324367,247.29841702659922,583.1523286871715,247.24933369318643C603.0008218419063,247.20025035977363,642.6978081513757,247.59211238226604,662.5463013061105,247.6420003604889C681.7545204881119,247.69027904909166,720.1709588521148,247.83511511489993,739.3791780341162,247.6420003604889C759.227671188851,247.44244844759749,798.9246574983205,246.32077358239337,818.7731506530553,246.0713336912791C837.9813698350567,245.8299402482653,876.3978081990595,245.82350308978494,895.6060273810609,245.67866702397666C915.4545205357957,245.5290030893081,955.1515068452652,245.08966702302297,975,244.89333368937176" stroke="#0b62a4" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,224.0820003223419C60.04849296399992,223.78750032186508,99.74547927346948,223.007158512692,119.59397242820427,222.9040003204346C137.52164366473892,222.8108251790408,173.3769861378082,223.34325455843393,191.30465737434284,223.296666987737C211.15315052907764,223.2450878916083,250.8501368385472,222.61110960957782,270.698629993282,222.5113336531321C289.9068491752834,222.41477627592658,328.3232875392862,222.22166152151556,347.5315067212876,222.5113336531321C367.37999987602234,222.81066152246922,407.07698618549193,224.36845387471828,426.9254793402267,224.8673336569468C446.1336985222281,225.35012054297442,484.5501368862309,226.48627901475936,503.75835606823233,226.4380003261566C523.6068492229671,226.38811234793377,563.3038355324367,224.76916699012122,583.1523286871715,224.4746669896444C603.0008218419063,224.18016698916756,642.6978081513757,224.28155223523333,662.5463013061105,224.0820003223419C681.7545204881119,223.88888556793088,720.1709588521148,223.04883638624287,739.3791780341162,222.9040003204346C759.227671188851,222.75433638576604,798.9246574983205,222.70444840754317,818.7731506530553,222.9040003204346C837.9813698350567,223.09711507484562,876.3978081990595,224.4746669896444,895.6060273810609,224.4746669896444C915.4545205357957,224.4746669896444,955.1515068452652,223.29666698773704,975,222.9040003204346" stroke="#9440ed" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,241.75200035095216C60.04849296399992,241.75200035095216,99.74547927346948,241.70042125482345,119.59397242820427,241.75200035095216C137.52164366473892,241.79858792164907,173.3769861378082,242.1446670182546,191.30465737434284,242.1446670182546C211.15315052907764,242.1446670182546,250.8501368385472,241.85177630739787,270.698629993282,241.75200035095216C289.9068491752834,241.65544297374663,328.3232875392862,241.40761237225246,347.5315067212876,241.3593336836497C367.37999987602234,241.30944570542687,407.07698618549193,241.3593336836497,426.9254793402267,241.3593336836497C446.1336985222281,241.3593336836497,484.5501368862309,241.40761237225246,503.75835606823233,241.3593336836497C523.6068492229671,241.30944570542687,563.3038355324367,240.91758368293446,583.1523286871715,240.96666701634726C603.0008218419063,241.01575034976005,642.6978081513757,241.70211237272932,662.5463013061105,241.75200035095216C681.7545204881119,241.8002790395549,720.1709588521148,241.3593336836497,739.3791780341162,241.3593336836497C759.227671188851,241.3593336836497,798.9246574983205,241.70211237272932,818.7731506530553,241.75200035095216C837.9813698350567,241.8002790395549,876.3978081990595,241.8002790395549,895.6060273810609,241.75200035095216C915.4545205357957,241.70211237272932,955.1515068452652,241.45750035047533,975,241.3593336836497" stroke="#cb4b4b" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,182.45933358828228C60.04849296399992,183.24466692288718,99.74547927346948,184.4143477157415,119.59397242820427,185.60066692670188C137.52164366473892,186.6721810527306,173.3769861378082,190.23280252742228,191.30465737434284,191.4906669362386C211.15315052907764,192.8833025317138,250.8501368385472,195.2547953576338,270.698629993282,196.202666943868C289.9068491752834,197.11996202732044,328.3232875392862,198.46854672895753,347.5315067212876,198.95133361498515C367.37999987602234,199.45021339721367,407.07698618549193,200.17922159511534,426.9254793402267,200.1293336168925C446.1336985222281,200.08105492828975,484.5501368862309,198.22071612746336,503.75835606823233,198.5586669476827C523.6068492229671,198.90788279524267,563.3038355324367,201.7490836195151,583.1523286871715,202.87800028800964C603.0008218419063,204.0069169565042,642.6978081513757,206.44257679651344,662.5463013061105,207.59000029563904C681.7545204881119,208.70041013350254,720.1709588521148,211.0403172411163,739.3791780341162,211.909333635966C759.227671188851,212.80731724397734,798.9246574983205,214.25889648130033,818.7731506530553,214.65800030708314C837.9813698350567,215.04422981590523,876.3978081990595,214.71271615416626,895.6060273810609,215.0506669743856C915.4545205357957,215.39988282194557,955.1515068452652,216.81766697724663,975,217.4066669782003" stroke="#edc240" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,258.6366670449575C60.04849296399992,258.7348337117831,99.74547927346948,258.9777546161312,119.59397242820427,259.0293337122599C137.52164366473892,259.0759212829568,173.3769861378082,259.0293337122599,191.30465737434284,259.0293337122599C211.15315052907764,259.0293337122599,250.8501368385472,259.0293337122599,270.698629993282,259.0293337122599C289.9068491752834,259.0293337122599,328.3232875392862,259.0293337122599,347.5315067212876,259.0293337122599C367.37999987602234,259.0293337122599,407.07698618549193,259.0293337122599,426.9254793402267,259.0293337122599C446.1336985222281,259.0293337122599,484.5501368862309,259.0293337122599,503.75835606823233,259.0293337122599C523.6068492229671,259.0293337122599,563.3038355324367,259.0293337122599,583.1523286871715,259.0293337122599C603.0008218419063,259.0293337122599,642.6978081513757,259.52821349448845,662.5463013061105,259.0293337122599C681.7545204881119,258.5465468262323,720.1709588521148,256.6958637631265,739.3791780341162,255.10266703923543C759.227671188851,253.45636375788132,798.9246574983205,246.91942932106758,818.7731506530553,246.0713336912791C837.9813698350567,245.2505959850322,876.3978081990595,246.78585828259992,895.6060273810609,248.42733369509378C915.4545205357957,250.12352495467076,955.1515068452652,256.6733337084452,975,259.4220003795624" stroke="#afd8f8" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,250.39066703160603C60.04849296399992,250.58700036525727,99.74547927346948,251.07284217395352,119.59397242820427,251.17600036621093C137.52164366473892,251.26917550760473,173.3769861378082,251.08282522481713,191.30465737434284,251.17600036621093C211.15315052907764,251.27915855846834,250.8501368385472,251.81166976614728,270.698629993282,251.96133370081583C289.9068491752834,252.1061697666241,328.3232875392862,252.25744299091275,347.5315067212876,252.35400036811828C367.37999987602234,252.453776324564,407.07698618549193,252.59700310075218,426.9254793402267,252.74666703542073C446.1336985222281,252.891503101229,484.5501368862309,253.38716430421735,503.75835606823233,253.53200037002563C523.6068492229671,253.68166430469418,563.3038355324367,253.82650037050246,583.1523286871715,253.92466703732808C603.0008218419063,254.0228337041537,642.6978081513757,254.2674457264077,662.5463013061105,254.31733370463053C681.7545204881119,254.36561239323328,720.1709588521148,254.31733370463053,739.3791780341162,254.31733370463053C759.227671188851,254.31733370463053,798.9246574983205,254.2674457264077,818.7731506530553,254.31733370463053C837.9813698350567,254.36561239323328,876.3978081990595,254.66172168333023,895.6060273810609,254.71000037193298C915.4545205357957,254.75988835015582,955.1515068452652,254.71000037193298,975,254.71000037193298" stroke="#4da74d" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,43.455333363215146C60.04849296399992,43.455333363215146,99.74547927346948,43.76480793998741,119.59397242820427,43.455333363215146C137.52164366473892,43.17580793903374,173.3769861378082,41.611796637066355,191.30465737434284,41.09933335940045C211.15315052907764,40.53196330198462,250.8501368385472,39.38543991400246,270.698629993282,39.1360000228882C289.9068491752834,38.8946065798744,328.3232875392862,39.08772133428544,347.5315067212876,39.1360000228882C367.37999987602234,39.18588800111105,407.07698618549193,39.42889073374494,426.9254793402267,39.52866669019065C446.1336985222281,39.62522406739617,484.5501368862309,39.728218603082055,503.75835606823233,39.9213333574931C523.6068492229671,40.120885270384505,563.3038355324367,41.393833359877284,583.1523286871715,41.09933335940045C603.0008218419063,40.80483335892361,642.6978081513757,37.964437179461214,662.5463013061105,37.5653333536784C681.7545204881119,37.179103844856314,720.1709588521148,37.764885266569806,739.3791780341162,37.95800002098085C759.227671188851,38.157551933872256,798.9246574983205,38.73689619710538,818.7731506530553,39.1360000228882C837.9813698350567,39.52222953171028,876.3978081990595,40.568267784770086,895.6060273810609,41.09933335940045C915.4545205357957,41.64810111985182,955.1515068452652,42.86633336226147,975,43.455333363215146" stroke="#7a92a3" fill="none" style=""></path><path stroke-width="3" d="M40.19999980926514,241.75200035095216C60.04849296399992,240.86850034952164,99.74547927346948,239.19800317167562,119.59397242820427,238.2180003452301C137.52164366473892,237.332836501989,173.3769861378082,235.036734803356,191.30465737434284,234.2913336722056C211.15315052907764,233.4660681341462,250.8501368385472,232.53398940706515,270.698629993282,231.9353336683909C289.9068491752834,231.3559894051578,328.3232875392862,230.2069566164121,347.5315067212876,229.5793336645762C367.37999987602234,228.93078994767913,407.07698618549193,227.37943475391043,426.9254793402267,226.83066699345906C446.1336985222281,226.2996014188287,484.5501368862309,225.74278721027687,503.75835606823233,225.26000032424926C523.6068492229671,224.76112054202073,563.3038355324367,223.49300032138825,583.1523286871715,222.9040003204346C603.0008218419063,222.31500031948093,642.6978081513757,220.69766425128844,662.5463013061105,220.5480003166199C681.7545204881119,220.4031642508116,720.1709588521148,220.95354130088305,739.3791780341162,221.7260003185272C759.227671188851,222.52420797009285,798.9246574983205,226.8805549716819,818.7731506530553,226.83066699345906C837.9813698350567,226.7823883048563,876.3978081990595,223.6507107041573,895.6060273810609,221.3333336512248C915.4545205357957,218.9387106965279,955.1515068452652,211.32033363501233,975,207.9826669629415" stroke="#0b62a4" fill="none" style=""></path><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="251.96133370081583" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="251.96133370081583" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="251.56866703351338" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="251.96133370081583" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="250.39066703160603" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="248.03466702779133" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="248.03466702779133" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="247.24933369318643" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="247.6420003604889" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="247.6420003604889" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="246.0713336912791" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="245.67866702397666" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="7" cy="244.89333368937176" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="224.0820003223419" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="222.9040003204346" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="223.296666987737" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="222.5113336531321" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="222.5113336531321" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="224.8673336569468" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="226.4380003261566" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="224.4746669896444" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="224.0820003223419" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="222.9040003204346" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="222.9040003204346" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="4" cy="224.4746669896444" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#9440ed" r="7" cy="222.9040003204346" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.75200035095216" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.75200035095216" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="242.1446670182546" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.75200035095216" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.3593336836497" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.3593336836497" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.3593336836497" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="240.96666701634726" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.75200035095216" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.3593336836497" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.75200035095216" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="4" cy="241.75200035095216" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#cb4b4b" r="7" cy="241.3593336836497" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="182.45933358828228" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="185.60066692670188" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="191.4906669362386" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="196.202666943868" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="198.95133361498515" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="200.1293336168925" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="198.5586669476827" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="202.87800028800964" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="207.59000029563904" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="211.909333635966" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="214.65800030708314" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="4" cy="215.0506669743856" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#edc240" r="7" cy="217.4066669782003" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="258.6366670449575" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="259.0293337122599" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="255.10266703923543" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="246.0713336912791" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="4" cy="248.42733369509378" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#afd8f8" r="7" cy="259.4220003795624" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="250.39066703160603" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="251.17600036621093" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="251.17600036621093" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="251.96133370081583" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="252.35400036811828" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="252.74666703542073" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="253.53200037002563" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="253.92466703732808" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="254.31733370463053" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="254.31733370463053" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="254.31733370463053" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="4" cy="254.71000037193298" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#4da74d" r="7" cy="254.71000037193298" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="43.455333363215146" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="43.455333363215146" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="41.09933335940045" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="39.1360000228882" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="39.1360000228882" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="39.52866669019065" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="39.9213333574931" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="41.09933335940045" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="37.5653333536784" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="37.95800002098085" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="39.1360000228882" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="4" cy="41.09933335940045" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#7a92a3" r="7" cy="43.455333363215146" cx="975"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="241.75200035095216" cx="40.19999980926514"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="238.2180003452301" cx="119.59397242820427"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="234.2913336722056" cx="191.30465737434284"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="231.9353336683909" cx="270.698629993282"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="229.5793336645762" cx="347.5315067212876"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="226.83066699345906" cx="426.9254793402267"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="225.26000032424926" cx="503.75835606823233"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="222.9040003204346" cx="583.1523286871715"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="220.5480003166199" cx="662.5463013061105"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="221.7260003185272" cx="739.3791780341162"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="226.83066699345906" cx="818.7731506530553"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="4" cy="221.3333336512248" cx="895.6060273810609"></circle><circle stroke-width="1" style="" stroke="#ffffff" fill="#0b62a4" r="7" cy="207.9826669629415" cx="975"></circle></svg><div style="left: 904px; top: 53px;" class="morris-hover morris-default-style"><div class="morris-hover-row-label">2014-01</div><div class="morris-hover-point" style="color: #0b62a4">
  Win8:
  13.4
</div><div class="morris-hover-point" style="color: #7A92A3">
  Win7:
  55.3
</div><div class="morris-hover-point" style="color: #4da74d">
  Vista:
  1.5
</div><div class="morris-hover-point" style="color: #afd8f8">
  NT:
  0.3
</div><div class="morris-hover-point" style="color: #edc240">
  XP:
  11
</div><div class="morris-hover-point" style="color: #cb4b4b">
  Linux:
  4.9
</div><div class="morris-hover-point" style="color: #9440ed">
  Mac:
  9.6
</div><div class="morris-hover-point" style="color: #0b62a4">
  Mobile:
  4
</div></div></div>
			</div>
		</div>--%>
		<!--End Dashboard Tab 3-->
		<!--Start Dashboard Tab 4-->
		<div id="dashboard-servers" class="row" style="visibility: hidden; position: absolute;">
			<%--<div class="col-xs-12 col-sm-6 col-md-4 ow-server">
				<h4 class="page-header text-right"><i class="fa fa-windows"></i>#SRV-APP</h4>
				<small>Application server</small>
				<div class="ow-settings">
					<a href="#"><i class="fa fa-gears"></i></a>
				</div>
				<div class="row ow-server-bottom">
					<div class="col-sm-4">
						<div class="knob-slider">
							<div style="display: inline; width: 60px; height: 60px;"><canvas style="width: 60px; height: 60px;" height="75" width="75"></canvas><input style="width: 34px; height: 20px; position: absolute; vertical-align: middle; margin-top: 20px; margin-left: -47px; border: 0px none; background: none repeat scroll 0% 0% transparent; font: bold 12px Arial; text-align: center; color: rgb(106, 166, 214); padding: 0px;" id="knob-srv-1" class="knob" data-width="60" data-height="60" data-angleoffset="180" data-fgcolor="#6AA6D6" data-skin="tron" data-thickness=".2" value=""></div>CPU Load
						</div>
					</div>
					<div class="col-sm-8">
						<div class="row"><i class="fa fa-windows"></i> Windows 2008</div>
						<div class="row"><i class="fa fa-user"></i> Active users - 49</div>
						<div class="row"><i class="fa fa-bolt"></i> Uptime - 10 days</div>
					</div>
				</div>
			</div>--%>
			<%--<div class="col-xs-12 col-sm-6 col-md-4 ow-server">
				<h4 class="page-header text-right"><i class="fa fa-windows"></i>#DB-MASTER</h4>
				<small>SQL server</small>
				<div class="ow-settings">
					<a href="#"><i class="fa fa-gears"></i></a>
				</div>
				<div class="row ow-server-bottom">
					<div class="col-sm-4">
						<div class="knob-slider">
							<div style="display: inline; width: 60px; height: 60px;"><canvas style="width: 60px; height: 60px;" height="75" width="75"></canvas><input style="width: 34px; height: 20px; position: absolute; vertical-align: middle; margin-top: 20px; margin-left: -47px; border: 0px none; background: none repeat scroll 0% 0% transparent; font: bold 12px Arial; text-align: center; color: rgb(106, 166, 214); padding: 0px;" id="knob-srv-2" class="knob" data-width="60" data-height="60" data-angleoffset="180" data-fgcolor="#6AA6D6" data-skin="tron" data-thickness=".2" value=""></div>CPU Load
						</div>
					</div>
					<div class="col-sm-8">
						<div class="row"><i class="fa fa-windows"></i> Windows 2013</div>
						<div class="row"><i class="fa fa-user"></i> Active users - 39</div>
						<div class="row"><i class="fa fa-bolt"></i> Uptime - 2 month 1 day</div>
					</div>
				</div>
			</div>--%>
			<%--<div class="col-xs-12 col-sm-6 col-md-4 ow-server">
				<h4 class="page-header text-right"><i class="fa fa-linux"></i>#DB-WEB</h4>
				<small>MySQL server</small>
				<div class="ow-settings">
					<a href="#"><i class="fa fa-gears"></i></a>
				</div>
				<div class="row ow-server-bottom">
					<div class="col-sm-4">
						<div class="knob-slider">
							<div style="display: inline; width: 60px; height: 60px;"><canvas style="width: 60px; height: 60px;" height="75" width="75"></canvas><input style="width: 34px; height: 20px; position: absolute; vertical-align: middle; margin-top: 20px; margin-left: -47px; border: 0px none; background: none repeat scroll 0% 0% transparent; font: bold 12px Arial; text-align: center; color: rgb(106, 166, 214); padding: 0px;" id="knob-srv-3" class="knob" data-width="60" data-height="60" data-angleoffset="180" data-fgcolor="#6AA6D6" data-skin="tron" data-thickness=".2" value=""></div>CPU Load
						</div>
					</div>
					<div class="col-sm-8">
						<div class="row"><i class="fa fa-linux"></i> CentOS 6.5</div>
						<div class="row"><i class="fa fa-user"></i> Active users - 298</div>
						<div class="row"><i class="fa fa-bolt"></i> Uptime - 9 month 17 day</div>
					</div>
				</div>
			</div>--%>
		<%--	<div class="col-xs-12 col-sm-6 col-md-4 ow-server">
				<h4 class="page-header text-right"><i class="fa fa-linux"></i>#WWW-SRV</h4>
				<small>Web-server</small>
				<div class="ow-settings">
					<a href="#"><i class="fa fa-gears"></i></a>
				</div>
				<div class="row ow-server-bottom">
					<div class="col-sm-4">
						<div class="knob-slider">
							<div style="display: inline; width: 60px; height: 60px;"><canvas style="width: 60px; height: 60px;" height="75" width="75"></canvas><input style="width: 34px; height: 20px; position: absolute; vertical-align: middle; margin-top: 20px; margin-left: -47px; border: 0px none; background: none repeat scroll 0% 0% transparent; font: bold 12px Arial; text-align: center; color: rgb(106, 166, 214); padding: 0px;" id="knob-srv-4" class="knob" data-width="60" data-height="60" data-angleoffset="180" data-fgcolor="#6AA6D6" data-skin="tron" data-thickness=".2" value=""></div>CPU Load
						</div>
					</div>
					<div class="col-sm-8">
						<div class="row"><i class="fa fa-linux"></i> Centos 6.5</div>
						<div class="row"><i class="fa fa-user"></i> Active users - 1989</div>
						<div class="row"><i class="fa fa-bolt"></i> Uptime - 2 years 3 month</div>
					</div>
				</div>
			</div>--%>
			<%--<div class="col-xs-12 col-sm-6 col-md-4 ow-server">
				<h4 class="page-header text-right"><i class="fa fa-linux"></i>#PHONE-OFFICE</h4>
				<small>Asterisk</small>
				<div class="ow-settings">
					<a href="#"><i class="fa fa-gears"></i></a>
				</div>
				<div class="row ow-server-bottom">
					<div class="col-sm-4">
						<div class="knob-slider">
							<div style="display: inline; width: 60px; height: 60px;"><canvas style="width: 60px; height: 60px;" height="75" width="75"></canvas><input style="width: 34px; height: 20px; position: absolute; vertical-align: middle; margin-top: 20px; margin-left: -47px; border: 0px none; background: none repeat scroll 0% 0% transparent; font: bold 12px Arial; text-align: center; color: rgb(106, 166, 214); padding: 0px;" id="knob-srv-5" class="knob" data-width="60" data-height="60" data-angleoffset="180" data-fgcolor="#6AA6D6" data-skin="tron" data-thickness=".2" value=""></div>CPU Load
						</div>
					</div>
					<div class="col-sm-8">
						<div class="row"><i class="fa fa-linux"></i> Debian 6.4</div>
						<div class="row"><i class="fa fa-phone"></i> Active calls - 86</div>
						<div class="row"><i class="fa fa-bolt"></i> Uptime - 3 month 19 day</div>
					</div>
				</div>
			</div>--%>
			<%--<div class="col-xs-12 col-sm-6 col-md-4 ow-server">
				<h4 class="page-header text-right"><i class="fa fa-linux"></i>#DEVEL</h4>
				<small>DEV server</small>
				<div class="ow-settings">
					<a href="#"><i class="fa fa-gears"></i></a>
				</div>
				<div class="row ow-server-bottom">
					<div class="col-sm-4">
						<div class="knob-slider">
							<div style="display: inline; width: 60px; height: 60px;"><canvas style="width: 60px; height: 60px;" height="75" width="75"></canvas><input style="width: 34px; height: 20px; position: absolute; vertical-align: middle; margin-top: 20px; margin-left: -47px; border: 0px none; background: none repeat scroll 0% 0% transparent; font: bold 12px Arial; text-align: center; color: rgb(106, 166, 214); padding: 0px;" id="knob-srv-6" class="knob" data-width="60" data-height="60" data-angleoffset="180" data-fgcolor="#6AA6D6" data-skin="tron" data-thickness=".2" value=""></div>CPU Load
						</div>
					</div>
					<div class="col-sm-8">
						<div class="row"><i class="fa fa-linux"></i> CentOS 6.5</div>
						<div class="row"><i class="fa fa-archive"></i> Repositories - 17</div>
						<div class="row"><i class="fa fa-bolt"></i> Uptime - 4 month 21 day</div>
					</div>
				</div>
			</div>--%>
			<div class="clearfix"></div>
			<%--<div id="ow-server-footer">
				<a href="#" class="col-xs-4 col-sm-2 btn-default text-center"><i class="fa fa-sun-o"></i> <b>287</b> <span>Hosts</span></a>
				<a href="#" class="col-xs-4 col-sm-2 btn-default text-center"><i class="fa fa-envelope-o"></i> <b>56</b> <span>Messages</span></a>
				<a href="#" class="col-xs-4 col-sm-2 btn-default text-center"><i class="fa fa-desktop"></i> <b>85</b> <span>Stations</span></a>
				<a href="#" class="col-xs-4 col-sm-2 btn-default text-center"><i class="fa fa-info-circle"></i> <b>33</b> <span>Errors</span></a>
				<a href="#" class="col-xs-4 col-sm-2 btn-default text-center"><i class="fa fa-comments-o"></i> <b>1386</b> <span>Comments</span></a>
				<a href="#" class="col-xs-4 col-sm-2 btn-default text-center"><i class="fa fa-user"></i> <b>19985</b> <span>Clients</span></a>
			</div>--%>
		</div>
		<!--End Dashboard Tab 4-->
	</div>
	<div class="clearfix"></div>                                   
        <script Id="BooksIssuedTemplate" type="text/html">
        <tr>
			<td><span data-bind="text: bookTitle">-</span></td>
			<td data-bind="text: bookIssuedToUser">-</td>
			<td data-bind="text: bookIssueDate"><i class="fa fa-angle-up"></i>-</td>
			<td data-bind="text: bookReturnDate">-</td>

		</tr>
    </script>
    <script id="BooksListTemplate" type="text/html">
        <tr>
            <td><span data-bind="text: bookTitle">-</span></td>
            <td><span data-bind="text: bookAuthor">-</span></td>
            <td><span data-bind="text: bookQuantity">-</span></td>
            <td><span data-bind="text: bookRatings">-</span></td>
        </tr>

    </script>
</asp:Content>
