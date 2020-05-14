<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SCM_NoticeViewControl.ascx.cs" Inherits="Admin_SCM_NoticeViewControl" %>


<div style="border: 1px solid #d7d7d7">
<asp:Label ID="lblNoticeError" runat="server" ForeColor="Red"></asp:Label>
</div>



<div class="mtable b1">
	<div class="mtabler">
		<div class="mtablec"><div class="mtitle"><b>JobLink Project</b></div></div>
	</div>


		<div class="mtabler">
			<div class="mtablec">
				<div class="mtabler">
				<div class="mtablec mm"><b>Title</b></div>
				<div class="mtablec mi"><b><asp:Label ID="lblTitle" runat="server"></asp:Label></b></div>
				<div class="mtablec mm"><B>일자</b></div>
				<div class="mtablec mi"><b><asp:Label ID="lblps" runat="server"></asp:Label></b></div>
			</div>
		</div>
	</div>
</div>

		<br>




<% if (lblts1.Text != "")  { %>

<div class="mtable b1">
  <div class="mtabler">
    <div class="mtablec mmm">

      <div class="mtabler">
        <div class="mtablec">
          <div class="mtablec mm"><b>고객사</b></div>
          <div class="mtablec mi"><b><asp:Label ID="lblts1" runat="server"></asp:Label></b>&nbsp;&nbsp; Code <b><asp:Label ID="lblcode1" runat="server"></asp:Label></div>
        </div>
      </div>

      <div class="mtabler">
        <div class="mtablec">
          <div class="mtablec mm">이미지</div>
          <div class="mtablec mi">
          <% if (lblFileName.Text != "")  { %>
          <img src ="../../fileUpload/notice/<%= lblFileName.Text %>" width=500px; height=200px;>
          <%} else { %>
          <%} %>
          <!--<asp:Label ID="lblFileName" runat="server"></asp:Label><asp:Button  ID="btnFile"  runat="server" onclick="btnFile_Click" Text="download" />--></div>
          </div>
        </div>


        <div class="mtabler">
         <div class="mtablec">
          <div class="mtablec mm">프로젝트 명</div>
          <div class="mtablec mi"><asp:Label ID="lbllink1" runat="server"></asp:Label></div>
        </div>
       </div>

       <div class="mtabler">
        <div class="mtablec">
         <div class="mtablec mm">언어</div>
         <div class="mtablec mi"><asp:Label ID="lbllang1" runat="server"></asp:Label></div>
       </div>
      </div>

      <div class="mtabler">
       <div class="mtablec">
        <div class="mtablec mm">기술</div>
        <div class="mtablec mi"><asp:Label ID="lbltech1" runat="server"></asp:Label></div>
      </div>
     </div>

     <div class="mtabler">
      <div class="mtablec">
       <div class="mtablec mm">업무</div>
       <div class="mtablec mi"><asp:Label ID="lblsec1" runat="server"></asp:Label></div>
     </div>
    </div>

    <div class="mtabler">
     <div class="mtablec">
      <div class="mtablec mm">진행</div>
      <div class="mtablec mi"><asp:Label ID="lblProgress1" runat="server"></asp:Label></div>
    </div>
   </div>

   <div class="mtabler">
    <div class="mtablec">
     <div class="mtablec mm">마감</div>
     <div class="mtablec mi"><asp:Label ID="lblDead1" runat="server"></asp:Label></div>
   </div>
  </div>

  <div class="mtabler">
   <div class="mtablec">
    <div class="mtablec mm">업체</div>
    <div class="mtablec mi"><asp:Label ID="lblcorp1" runat="server"></asp:Label></div>
  </div>
 </div>
 </div>


 <div class="mtable">
     <div class="mtablec">
       <div class="mtable">
           <div class="mtabler">
             <div class="mtablec mm" style="width:5%; min-width:200px; height:520px;">내용</div>
           <div class="mtablec mi"><asp:Label ID="lblcs1" runat="server"></asp:Label></div>
         </div>
       </div>
     </div>
   </div>
 </div>
 </div>
 <%} else { %>
 <%} %>
 <br>


 <div class="mtable">
  <div class="mtablec b1">
   <div class="mtabler">
    <div class="mtablec">
       <div class="mtablec mm" style="width:1250px;">내용</div>
         <div class="mtablec mmmm"><asp:Label ID="lblContent" runat="server"></asp:Label></div>
<!--<tr><td colspan=2>
scm_project1/scm_project2/scm_project3/scm_project4/scm_project5 | 공공 프로젝트 2건 외  민간 프로젝트 2건 외 금융 프로젝트 2건 외 통신 프로젝트 2건 외<br><br>
JAVA  .NET   JQUERY ABAP  ANDROID  ASP  C  PROC-C  C++  COBOL  CSS   DESIGN   DELPHI  HTML5  IOS   JS  JSP  LINUX  NETWORK  PHP  POWER BUILDER  PYTHON    RUBY   VB  VC++   임베디드 <br><br>
공공 프로젝트 지원자는 반드시 COSA 자격증이 필요합니다.
</td></tr>-->
         </div>
         </div>
     <div class="mtabler">
      <div class="mtablec">
          <div class="mtablec b1"> scm_project1/scm_project2/scm_project3/scm_project4/scm_project5 | 공공 프로젝트 2건 외  민간 프로젝트 2건 외
           금융 프로젝트 2건 외 통신 프로젝트 2건 외 공공 프로젝트 지원자는 반드시 COSA 자격증이 필요합니다.</div>
        </div>
      </div>
    </div>
  </div>




   </div>
 </div>


<div class="mtable">
  <div class="mtabler">
    <div class="vtablec vf">
      <div class="vtablec" style="width:200px;">작성자</div>
      <div class="vtablec" style="width:20px;"> </style></div>
      <div class="vtablec" style="width:100px;"> 관리자 </div>
      <div class="vtablec" style="width:400px;"> </div>
      <div class="vtablec" style="width:400px;"> 작성일 </div>
      <div class="vtablec" style="width:20px;"> </div>
      <div class="vtablec" style="width:100px;"><asp:Label ID="lblPostDate" runat="server"></asp:Label></div>
      <div class="vtablec" style="width:400px;"> </div>
      <div class="vtablec" style="width:200px;"> 조회수 </div>
      <div class="vtablec" style="width:100px;"> </div>
      <div class="vtablec" style="width:100px;"><asp:Label ID="lblReadCount" runat="server"></asp:Label></div>
    </div>
  </div>
</div>




<table width=98% border="0">
		<tr><td><HR SIZE=1></td></tr>
                <tr><td align="right">
                        <asp:ImageButton ID="btnList" runat="server" ImageUrl="~/Images/list_bt.gif" OnClick="btnList_Click" />
                        <asp:ImageButton ID="btnmodify" runat="server" ImageUrl="~/Images/re_bt.gif" OnClick="btnmodify_Click" />
                        <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/Images/delete_bt.gif"
                                        OnClick="btnDelete_Click" style="height: 24px" />
                </td></tr>
            </table>


<!--
<asp:Label ID="lblFileName2" runat="server"></asp:Label><asp:Button  ID="btnFile2"  runat="server" onclick="btnFile_Click" Text="download" />
<asp:Label ID="lblFileName3" runat="server"></asp:Label><asp:Button  ID="btnFile3"  runat="server" onclick="btnFile_Click" Text="download" />
<asp:Label ID="lblFileName4" runat="server"></asp:Label><asp:Button  ID="btnFile4"  runat="server" onclick="btnFile_Click" Text="download" />
<asp:Label ID="lblFileName5" runat="server"></asp:Label><asp:Button  ID="btnFile5"  runat="server" onclick="btnFile_Click" Text="download" />-->
