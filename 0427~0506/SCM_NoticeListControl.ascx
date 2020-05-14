<%@ Control Language="C#" AutoEventWireup="true" CodeFile="SCM_NoticeListControl.ascx.cs" Inherits="Admin_SCM_NoticeListControl" %>
<asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>


                    <div class="wrap">
                      <div class="title"> 잡링크 프로젝트 알림 </div>



                        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                            <ContentTemplate>
                                <asp:GridView ID="ctlNoticeList" runat="server" AutoGenerateColumns="False" AllowPaging="True"
                                    Width="94%" Font-Size="11px" CellPadding="4" ForeColor="#333333"  PageSize="50" margin-left="70"
                                    OnPageIndexChanging="ctlNoticeList_PageIndexChanging">

                                    <Columns>
                                        <asp:BoundField DataField="SCM_NoticeID" HeaderText="번호" ItemStyle-Width="70px" ItemStyle-HorizontalAlign="Center"
                                            HeaderStyle-Width="5%" HeaderStyle-HorizontalAlign="Center" />


					  <asp:TemplateField HeaderText="TITLE">
                                            <ItemTemplate>
                                                <a href='SCM_NoticeView.aspx?SCM_NoticeID=<%#Eval("SCM_NoticeID") %>'>
                                                    <%#FuncCutStrng(Eval("Title"))%>
                                                    &nbsp;
                                                    <%#FuncNew(Eval("PostDate")) %>
                                                 </a>
                                            </ItemTemplate>
                                            <ItemStyle Width="15%" HorizontalAlign="Left" />
                                        </asp:TemplateField>


										<asp:TemplateField HeaderText ="구분">
                                <ItemTemplate>
                                    <%#FuncCutStrng(Eval("code1"))%>
                                </ItemTemplate>
                                <ItemStyle Width ="5%" HorizontalAlign ="center" />
                             </asp:TemplateField>

						<asp:TemplateField HeaderText ="고객사">
                                <ItemTemplate>
                                    <%#FuncCutStrng(Eval("ts1"))%>
                                </ItemTemplate>
                                <ItemStyle Width ="10%" HorizontalAlign ="left" />
                             </asp:TemplateField>



							 <asp:TemplateField HeaderText ="기간">
                                <ItemTemplate>
                                    <%#FuncCutStrng(Eval("link1"))%>
                                </ItemTemplate>
                                <ItemStyle Width ="5%" HorizontalAlign ="left" />
                             </asp:TemplateField>

							 <asp:TemplateField HeaderText ="언어">
                                <ItemTemplate>
                                    <%#FuncCutStrng(Eval("lang1"))%>
                                </ItemTemplate>
                                <ItemStyle Width ="8%" HorizontalAlign ="left" />
                             </asp:TemplateField>





                         <asp:TemplateField HeaderText ="종료">
                                <ItemTemplate>
                                    <%#FuncCutStrng(Eval("dead1"))%>
                                </ItemTemplate>
                                <ItemStyle Width ="8%" HorizontalAlign ="center" />
                             </asp:TemplateField>


						<asp:TemplateField HeaderText="진행">
                                            <ItemTemplate>
                                            &nbsp;<font color="<%#FuncCutStrng(Eval("Color"))%>"><b><%#FuncCutStrng(Eval("progress1"))%></b></font>
                                            </ItemTemplate>
                                            <ItemStyle Width="5%" HorizontalAlign="center" />
                                        </asp:TemplateField>





                                        <asp:BoundField DataField="PostDate" HeaderText="작성일" HtmlEncode="False" DataFormatString="{0:yyyy-MM-dd}">
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:BoundField>

                                        <asp:BoundField DataField="ReadCount" HeaderText="조회">
                                            <ItemStyle HorizontalAlign="Center"  Width="5%" />
                                        </asp:BoundField>


										 <asp:TemplateField HeaderText ="기술">
                                <ItemTemplate>
                                    <%#FuncCutStrng(Eval("tech1"))%>
                                </ItemTemplate>
                                <ItemStyle Width ="20%" HorizontalAlign ="left" />
                             </asp:TemplateField>



                                        <asp:TemplateField>
                                            <HeaderTemplate>
                                                <asp:CheckBox ID="chkAll" runat="server" AutoPostBack="true" OnCheckedChanged="chkAll_CheckedChanged" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <asp:CheckBox ID="chk" runat="server" />
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="center"   />
                                        </asp:TemplateField>















                                    </Columns>
                                    <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                                    <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                                    <EditRowStyle BackColor="#999999" />
                                    <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                                    <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                                    <HeaderStyle BackColor="#d7d7d7" Font-Bold="True" ForeColor="black" />
                                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                                </asp:GridView>
                                <asp:Label ID="lblError" runat="server" ForeColor="Red"></asp:Label>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </td>
                </tr>
                <tr>

                    </td>
                </tr>
<tr><td colspan=3 align=right>
</div>


<div class="footeradjust">

<table    border="0" cellpadding="1" cellspacing="1" align=right>
                <tr>
                    <td height="40" align="right" valign="top">
                         <asp:Panel ID="Panel1" runat="server" Width="100%" DefaultButton="btnSearch">
                             <asp:DropDownList ID="lstField" runat="server" CssClass="DropList">
                                 <asp:ListItem Selected="True" Value="Title">제목</asp:ListItem>
                                  <asp:ListItem Value="Content">내용</asp:ListItem>
                             </asp:DropDownList></td>

                        <td height="40" align="left" valign="top">
                           <asp:TextBox ID="txtQuery" runat="server" CssClass="txt"></asp:TextBox>
                        </td>
                              <td height="40" align="left" valign="top"><nobr><asp:ImageButton ID="btnSearch" runat="server" ImageUrl="~/Images/find_bt.gif" OnClick="btnSearch_Click" />
                                 <asp:ImageButton ID="btnWrite" runat="server" ImageUrl="~/Images/write_bt.gif" OnClick="btnWrite_Click" />
                                 <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="~/Images/delete_bt.gif" OnClick="btnDelete_Click" />
                                 <!--<asp:ImageButton ID="btnPush" runat="server" ImageUrl="~/Images/Push_bt.gif" OnClick="btnPush_Click" />-->
                              </td>
                         </asp:Panel>

<!--<td   align="center" valign="middle" width=100 bgcolor="red"><a href="./PushNotice.ashx?aaa=12345"><font color="#ffffff"><b>PushNotice</b></font></TD>-->
</tr></table>
</div></div>





</tr></table>




 </td></tr></table>
 </td></tr></table>
 </div>
