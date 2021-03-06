﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true"
    CodeBehind="ConsentDeclarationOld.aspx.cs" Inherits="WindowsCEConsentForms.OutsideOR.OutsideORConsentDeclarationOld" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <ul class="content">
        <li class="center">
            <h3>
                Outside OR Consent Declaration Form</h3>
        </li>
        <li class="center">
            <p>
                CONSENT FOR DIAGNOSTIC PROCEDURE OR OPERATION
            </p>
        </li>
        <li>
            <div class="right smallest">
                MRIN# :</div>
            <div class="right small">
                <asp:Label ID="LblPatientMRId" runat="server" CssClass="errorInfo"></asp:Label></div>
            <div class="right smallest">
                Name :
            </div>
            <div class="right small">
                <asp:Label runat="server" ID="LblPatientName" CssClass="errorInfo"></asp:Label></div>
            <div class="right smallest">
                Date :
            </div>
            <div class="right small">
                <asp:Label runat="server" ID="LblDate" CssClass="errorInfo"></asp:Label></div>
            <div class="right smallest">
                Time :</div>
            <div class="right small">
                <asp:Label runat="server" ID="LblTime" CssClass="errorInfo"></asp:Label></div>
            <div class="clear">
            </div>
        </li>
        <li>
            <p>
                I here by authorize Doctor(s)
                <asp:Label runat="server" ID="LbldoctorName" CssClass="errorInfo"></asp:Label>
                to perform upon
                <asp:Label runat="server" ID="LnlPatientName" CssClass="errorInfo"></asp:Label>
                the following procedure or operation :
                <asp:Label runat="server" ID="LblProcedurename" CssClass="errorInfo"></asp:Label>
            </p>
        </li>
        <li>
            <p>
                I Understand and that no guarantee have been made to me that this operation will
                improve my condition.
            </p>
        </li>
        <li>
            <div class="boxLeft">
                <asp:CheckBox runat="server" ID="ChkPatientisUnableToSign" Text="Patient is unable to sign?"
                    AutoPostBack="True" OnCheckedChanged="ChkPatientisUnableToSign_CheckedChanged" />
            </div>
        </li>
        <li class="PatientReason">
            <asp:Panel runat="server" ID="PnlPatientReason1">
                Please specify reason
                <br />
                <asp:TextBox runat="server" ID="TxtPatientNotSignedBecause"></asp:TextBox>
            </asp:Panel>
        </li>
        <li class="PatientReason">
            <asp:Panel runat="server" ID="PnlPatientReason2">
                <div>
                    If patient is unable to sign/person authorized to sign consent / relationship to
                    patient.</div>
                <div class="sig1 sigWrapper">
                    <canvas class="pad" width="198" height="55"></canvas>
                    <input type="hidden" name="HdnImage1" class="HdnImage1" value='<%= ViewState["Signature1"].ToString() %>' />
                </div>
                <div class="clear">
                </div>
            </asp:Panel>
        </li>
        <li class="PatientSign">
            <asp:Panel runat="server" ID="PnlPatientSign">
                <div>
                    Patient Signature</div>
                <div class="sig2 sigWrapper">
                    <canvas class="pad" width="198" height="55"></canvas>
                    <input type="hidden" name="HdnImage2" class="HdnImage2" value='<%= ViewState["Signature2"].ToString() %>' />
                </div>
                <div class="clear">
                </div>
            </asp:Panel>
        </li>
        <li>
            <div>
                Interpreted by
            </div>
            <div class="sig3 sigWrapper">
                <canvas class="pad" width="198" height="55"></canvas>
                <input type="hidden" name="HdnImage3" class="HdnImage3" value='<%= ViewState["Signature3"].ToString() %>' />
            </div>
            <div class="clear">
            </div>
        </li>
        <li>
            <div>
                Witness To Signature Only</div>
            <div class="sig4 sigWrapper">
                <canvas class="pad" width="198" height="55"></canvas>
                <input type="hidden" name="HdnImage4" class="HdnImage4" value='<%= ViewState["Signature4"].ToString() %>' />
            </div>
            <div class="clear">
            </div>
        </li>
        <!--
        <li>
            <div>
                I declare that I or my associates doctors
                <asp:Label runat="server" ID="LblAssociateDoctors" CssClass="errorInfo"></asp:Label>
                Personally explained the above information to the patient or the patient's representative.</div>
        </li>
        <li>
            <div class="sig5 sigWrapper">
                <canvas class="pad" width="198" height="55"></canvas>
                <input type="hidden" name="HdnImage5" class="HdnImage5" value='<%= ViewState["Signature5"].ToString() %>' />
            </div>
            <div class="clear">
            </div>
        </li>
-->
        <li>
            <asp:Label runat="server" ID="LblError" CssClass="errorInfo"></asp:Label>
        </li>
        <li class="center">
            <asp:Button runat="server" ID="BtnPrevious" Text="Prev" OnClick="BtnPrevious_Click1" />
            <asp:Button runat="server" ID="BtnCompleted" Text="Complete" OnClick="BtnCompleted_Click"
                OnClientClick="javascript: return confirm('Are you sure that do you want to complete the form?');" />
        </li>
    </ul>
</asp:Content>