﻿using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Text;
using WindowsCEConsentForms.ConsentFormSvc;

namespace WindowsCEConsentForms.PlasmanApheresis
{
    public partial class ConsentDeclaration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string patientId;
                string location;
                if (!IsPostBack)
                {
                    try
                    {
                        HdnPatientId.Value = Session["PatientID"].ToString();
                        patientId = HdnPatientId.Value;
                    }
                    catch (Exception)
                    {
                        Response.Redirect("/PatientConsent.aspx");
                        return;
                    }
                    try
                    {
                        HdnLocation.Value = Session["Location"].ToString();
                        location = HdnLocation.Value;
                    }
                    catch (Exception)
                    {
                        Response.Redirect("/PatientConsent.aspx");
                        return;
                    }
                }
                else
                {
                    try
                    {
                        patientId = Session["PatientID"].ToString();
                    }
                    catch (Exception)
                    {
                        if (string.IsNullOrEmpty(HdnPatientId.Value))
                        {
                            Response.Redirect("/PatientConsent.aspx");
                            return;
                        }
                        patientId = HdnPatientId.Value;
                        Session["PatientID"] = patientId;
                    }

                    try
                    {
                        location = Session["Location"].ToString();
                    }
                    catch (Exception)
                    {
                        if (string.IsNullOrEmpty(HdnPatientId.Value))
                        {
                            Response.Redirect("/PatientConsent.aspx");
                            return;
                        }
                        location = HdnLocation.Value;
                        Session["Location"] = location;
                    }
                }

                if (!string.IsNullOrEmpty(patientId))
                {
                    var formHandlerServiceClient = Utilities.GetConsentFormSvcClient();
                    var patientDetail = formHandlerServiceClient.GetPatientDetail(patientId, ConsentType.PlasmanApheresis.ToString(), location);
                    if (patientDetail != null)
                        LblPatientName.Text = patientDetail.name;

                    var primaryDoctors = new List<PrimaryDoctor> { new PrimaryDoctor() { Id = 0, Name = "----Select Primary Doctor----" } };
                    var physicians = formHandlerServiceClient.GetDoctorDetails();
                    if (physicians != null)
                    {
                        primaryDoctors.AddRange(physicians.Select(doctorDetails => new PrimaryDoctor { Name = doctorDetails.Lname + ", " + doctorDetails.Fname, Id = doctorDetails.ID }));
                    }

                    ViewState["PrimaryDoctors"] = primaryDoctors;
                }
                else
                    ViewState["PrimaryDoctors"] = new List<PrimaryDoctor>();

                DeclarationSignatures.BtnCompleted.Click += BtnCompleted_Click;
                DeclarationSignatures.BtnReset.Click += BtnReset_Click;

                if (!IsPostBack)
                {
                    ResetSignatures();
                    ViewState["doctorSelectedIndex"] = 0;
                }
                else
                {
                    if (Request.Form[SignatureType.DoctorSign1.ToString()] != null)
                        ViewState[SignatureType.DoctorSign1.ToString()] = Request.Form[SignatureType.DoctorSign1.ToString()];
                    if (Request.Form[SignatureType.DoctorSign2.ToString()] != null)
                        ViewState[SignatureType.DoctorSign2.ToString()] = Request.Form[SignatureType.DoctorSign2.ToString()];
                    if (Request.Form[SignatureType.DoctorSign3.ToString()] != null)
                        ViewState[SignatureType.DoctorSign3.ToString()] = Request.Form[SignatureType.DoctorSign3.ToString()];
                    if (Request.Form[SignatureType.DoctorSign4.ToString()] != null)
                        ViewState[SignatureType.DoctorSign4.ToString()] = Request.Form[SignatureType.DoctorSign4.ToString()];
                    if (Request.Form[SignatureType.DoctorSign5.ToString()] != null)
                        ViewState[SignatureType.DoctorSign5.ToString()] = Request.Form[SignatureType.DoctorSign5.ToString()];
                    if (Request.Form[SignatureType.DoctorSign6.ToString()] != null)
                        ViewState[SignatureType.DoctorSign6.ToString()] = Request.Form[SignatureType.DoctorSign6.ToString()];
                    if (Request.Form[SignatureType.DoctorSign7.ToString()] != null)
                        ViewState[SignatureType.DoctorSign7.ToString()] = Request.Form[SignatureType.DoctorSign7.ToString()];

                    ViewState["doctorSelectedIndex"] = Request.Form["DdlPrimaryDoctors"];
                }
            }
            catch (Exception ex)
            {
                var client = Utilities.GetConsentFormSvcClient();
                client.CreateLog(Utilities.GetUsername(Session), LogType.E, GetType().Name + "-" + new StackTrace().GetFrame(0).GetMethod(), ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        private void BtnReset_Click(object sender, EventArgs e)
        {
            ResetSignatures();

            DeclarationSignatures.ResetSignatures();

            ViewState["doctorSelectedIndex"] = 0;

            //ViewState["PrimaryDoctors"] = new List<PrimaryDoctor>();
        }

        protected void BtnCompleted_Click(object sender, EventArgs e)
        {
            try
            {
                const ConsentType consentType = ConsentType.PlasmanApheresis;

                //validation
                var lblError = DeclarationSignatures.LblError;

                lblError.Text = string.Empty;

                if (string.IsNullOrEmpty(Request["DdlPrimaryDoctors"]))
                    lblError.Text += "<br /> Please select physician.";

                DeclarationSignatures.ValidateForm();

                if (string.IsNullOrEmpty(Request.Form[SignatureType.DoctorSign1.ToString()]) ||
                   string.IsNullOrEmpty(Request.Form[SignatureType.DoctorSign2.ToString()]) ||
                   string.IsNullOrEmpty(Request.Form[SignatureType.DoctorSign3.ToString()]) ||
                   string.IsNullOrEmpty(Request.Form[SignatureType.DoctorSign4.ToString()]))
                {
                    lblError.Text = "Please input signatures.";
                }

                if (string.IsNullOrEmpty(Request.Form["DdlPrimaryDoctors"]) || Request.Form["DdlPrimaryDoctors"] == "0")
                    lblError.Text += "Please select physician.";

                if (!string.IsNullOrEmpty(lblError.Text))
                    return;

                string patientId;
                try
                {
                    patientId = Session["PatientID"].ToString();
                }
                catch (Exception)
                {
                    if (string.IsNullOrEmpty(HdnPatientId.Value))
                    {
                        Response.Redirect("/PatientConsent.aspx");
                        return;
                    }

                    patientId = HdnPatientId.Value;
                    Session["PatientID"] = patientId;
                }

                string location;
                try
                {
                    location = Session["Location"].ToString();
                }
                catch (Exception)
                {
                    if (string.IsNullOrEmpty(HdnPatientId.Value))
                    {
                        Response.Redirect("/PatientConsent.aspx");
                        return;
                    }
                    location = HdnLocation.Value;
                    Session["Location"] = location;
                }

                string ip = Request.ServerVariables["REMOTE_ADDR"];
                string device;
                if (Request.Browser.IsMobileDevice)
                    device = Request.Browser.Browser + " " + Request.Browser.Version;
                else
                    device = Request.Browser.Browser + " " + Request.Browser.Version;

                var signatureses = new List<Signatures>();

                if (Request.Form[SignatureType.DoctorSign1.ToString()] != null)
                {
                    var bytes = Encoding.ASCII.GetBytes(Request.Form[SignatureType.DoctorSign1.ToString()]);
                    signatureses.Add(new Signatures
                                         {
                                             _name = string.Empty,
                                             _signatureContent = Encoding.ASCII.GetString(bytes),
                                             _signatureType = SignatureType.DoctorSign1
                                         });
                }

                if (Request.Form[SignatureType.DoctorSign2.ToString()] != null)
                {
                    var bytes = Encoding.ASCII.GetBytes(Request.Form[SignatureType.DoctorSign2.ToString()]);
                    signatureses.Add(new Signatures
                    {
                        _name = string.Empty,
                        _signatureContent = Encoding.ASCII.GetString(bytes),
                        _signatureType = SignatureType.DoctorSign2
                    });
                }

                if (Request.Form[SignatureType.DoctorSign3.ToString()] != null)
                {
                    var bytes = Encoding.ASCII.GetBytes(Request.Form[SignatureType.DoctorSign3.ToString()]);
                    signatureses.Add(new Signatures
                    {
                        _name = string.Empty,
                        _signatureContent = Encoding.ASCII.GetString(bytes),
                        _signatureType = SignatureType.DoctorSign3
                    });
                }

                if (Request.Form[SignatureType.DoctorSign4.ToString()] != null)
                {
                    var bytes = Encoding.ASCII.GetBytes(Request.Form[SignatureType.DoctorSign4.ToString()]);
                    signatureses.Add(new Signatures
                    {
                        _name = string.Empty,
                        _signatureContent = Encoding.ASCII.GetString(bytes),
                        _signatureType = SignatureType.DoctorSign4
                    });
                }

                if (Request.Form[SignatureType.DoctorSign5.ToString()] != null)
                {
                    var bytes = Encoding.ASCII.GetBytes(Request.Form[SignatureType.DoctorSign5.ToString()]);
                    signatureses.Add(new Signatures
                    {
                        _name = string.Empty,
                        _signatureContent = Encoding.ASCII.GetString(bytes),
                        _signatureType = SignatureType.DoctorSign5
                    });
                }

                signatureses.AddRange(DeclarationSignatures.GetSignatures());

                string empID = string.Empty;
                if (Session["EmpID"] != null)
                    empID = Session["EmpID"].ToString();

                var treatment = new Treatment
                                    {
                                        _patientId = patientId,
                                        _consentType = consentType,
                                        _signatureses = signatureses.ToArray(),
                                        _isPatientUnableSign = DeclarationSignatures.ChkPatientisUnableToSign.Checked,
                                        _unableToSignReason = DeclarationSignatures.TxtPatientNotSignedBecause.Text,
                                        _translatedBy = DeclarationSignatures.TxtTranslatedBy.Text,
                                        _trackingInformation = new TrackingInformation
                                                                   {
                                                                       _device = device,
                                                                       _iP = ip
                                                                   },
                                        _doctorAndPrcedures = new DoctorAndProcedure[1] { new DoctorAndProcedure { _precedures = string.Empty, _primaryDoctorId = Request["DdlPrimaryDoctors"] } },
                                        _empID = empID
                                    };

                var formHandlerServiceClient = Utilities.GetConsentFormSvcClient();
                formHandlerServiceClient.AddTreatment(treatment);
                Utilities.GeneratePdfAndUploadToSharePointSite(formHandlerServiceClient, consentType, patientId, Request, location);
                try
                {
                    Response.Redirect(Utilities.GetNextFormUrl(consentType, Session));
                }
                catch (Exception)
                {
                    Response.Redirect("/PatientConsent.aspx");
                }
            }
            catch (Exception ex)
            {
                var client = Utilities.GetConsentFormSvcClient();
                client.CreateLog(Utilities.GetUsername(Session), LogType.E, GetType().Name + "-" + new StackTrace().GetFrame(0).GetMethod().ToString(),
                                 ex.Message + Environment.NewLine + ex.StackTrace);
            }
        }

        private void ResetSignatures()
        {
            ViewState[SignatureType.DoctorSign1.ToString()] = string.Empty;
            ViewState[SignatureType.DoctorSign2.ToString()] = string.Empty;
            ViewState[SignatureType.DoctorSign3.ToString()] = string.Empty;
            ViewState[SignatureType.DoctorSign4.ToString()] = string.Empty;
            ViewState[SignatureType.DoctorSign5.ToString()] = string.Empty;
            ViewState[SignatureType.DoctorSign6.ToString()] = string.Empty;
            ViewState[SignatureType.DoctorSign7.ToString()] = string.Empty;
        }
    }
}