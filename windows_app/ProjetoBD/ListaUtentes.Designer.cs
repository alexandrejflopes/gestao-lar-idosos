using System;
using System.Windows.Forms;

namespace ProjetoBD
{
    partial class ListaUtentes
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(ListaUtentes_FormClosing);
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ListaUtentes));
            this.panel1 = new System.Windows.Forms.Panel();
            this.label19 = new System.Windows.Forms.Label();
            this.botaoVerMais = new System.Windows.Forms.Button();
            this.txtID = new System.Windows.Forms.TextBox();
            this.Label11 = new System.Windows.Forms.Label();
            this.Label9 = new System.Windows.Forms.Label();
            this.Label5 = new System.Windows.Forms.Label();
            this.Label2 = new System.Windows.Forms.Label();
            this.Label1 = new System.Windows.Forms.Label();
            this.txtSexo = new System.Windows.Forms.TextBox();
            this.txtNasc = new System.Windows.Forms.TextBox();
            this.txtAlcunha = new System.Windows.Forms.TextBox();
            this.txtNome = new System.Windows.Forms.TextBox();
            this.botaoEliminarUtente = new System.Windows.Forms.Button();
            this.listBoxUtentes = new System.Windows.Forms.ListBox();
            this.botaoSair = new System.Windows.Forms.Button();
            this.buttonAddUtente = new System.Windows.Forms.Button();
            this.labelTotalUtentes = new System.Windows.Forms.Label();
            this.textTotalUtentes = new System.Windows.Forms.Label();
            this.panel2 = new System.Windows.Forms.Panel();
            this.panel1.SuspendLayout();
            this.panel2.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Controls.Add(this.label19);
            this.panel1.Controls.Add(this.botaoVerMais);
            this.panel1.Controls.Add(this.txtID);
            this.panel1.Controls.Add(this.Label11);
            this.panel1.Controls.Add(this.Label9);
            this.panel1.Controls.Add(this.Label5);
            this.panel1.Controls.Add(this.Label2);
            this.panel1.Controls.Add(this.Label1);
            this.panel1.Controls.Add(this.txtSexo);
            this.panel1.Controls.Add(this.txtNasc);
            this.panel1.Controls.Add(this.txtAlcunha);
            this.panel1.Controls.Add(this.txtNome);
            this.panel1.Controls.Add(this.botaoEliminarUtente);
            this.panel1.Location = new System.Drawing.Point(491, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(539, 532);
            this.panel1.TabIndex = 0;
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Underline))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.ForeColor = System.Drawing.Color.DimGray;
            this.label19.Location = new System.Drawing.Point(41, 38);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(144, 46);
            this.label19.TabIndex = 168;
            this.label19.Text = "Resumo";
            // 
            // botaoVerMais
            // 
            this.botaoVerMais.BackColor = System.Drawing.Color.MediumTurquoise;
            this.botaoVerMais.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoVerMais.ForeColor = System.Drawing.Color.White;
            this.botaoVerMais.Location = new System.Drawing.Point(86, 407);
            this.botaoVerMais.Name = "botaoVerMais";
            this.botaoVerMais.Size = new System.Drawing.Size(155, 52);
            this.botaoVerMais.TabIndex = 167;
            this.botaoVerMais.Text = "Ver mais";
            this.botaoVerMais.UseVisualStyleBackColor = false;
            this.botaoVerMais.Click += new System.EventHandler(this.verMais_Click);
            // 
            // txtID
            // 
            this.txtID.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtID.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.txtID.Location = new System.Drawing.Point(48, 157);
            this.txtID.Margin = new System.Windows.Forms.Padding(4);
            this.txtID.Name = "txtID";
            this.txtID.ReadOnly = true;
            this.txtID.Size = new System.Drawing.Size(91, 30);
            this.txtID.TabIndex = 166;
            // 
            // Label11
            // 
            this.Label11.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label11.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label11.Location = new System.Drawing.Point(48, 124);
            this.Label11.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.Label11.Name = "Label11";
            this.Label11.Size = new System.Drawing.Size(96, 20);
            this.Label11.TabIndex = 165;
            this.Label11.Text = "Utente nº";
            // 
            // Label9
            // 
            this.Label9.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label9.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label9.Location = new System.Drawing.Point(279, 276);
            this.Label9.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.Label9.Name = "Label9";
            this.Label9.Size = new System.Drawing.Size(59, 20);
            this.Label9.TabIndex = 150;
            this.Label9.Text = "Sexo";
            // 
            // Label5
            // 
            this.Label5.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label5.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label5.Location = new System.Drawing.Point(48, 276);
            this.Label5.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.Label5.Name = "Label5";
            this.Label5.Size = new System.Drawing.Size(209, 20);
            this.Label5.TabIndex = 148;
            this.Label5.Text = "Data de nascimento";
            // 
            // Label2
            // 
            this.Label2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label2.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label2.Location = new System.Drawing.Point(48, 200);
            this.Label2.Margin = new System.Windows.Forms.Padding(4, 4, 4, 1);
            this.Label2.Name = "Label2";
            this.Label2.Size = new System.Drawing.Size(380, 31);
            this.Label2.TabIndex = 144;
            this.Label2.Text = "Nome pelo qual gosta de tratado(a): ";
            this.Label2.Click += new System.EventHandler(this.Label2_Click);
            // 
            // Label1
            // 
            this.Label1.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.Label1.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.Label1.Location = new System.Drawing.Point(161, 124);
            this.Label1.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.Label1.Name = "Label1";
            this.Label1.Size = new System.Drawing.Size(96, 20);
            this.Label1.TabIndex = 142;
            this.Label1.Text = "Nome";
            // 
            // txtSexo
            // 
            this.txtSexo.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtSexo.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.txtSexo.Location = new System.Drawing.Point(283, 309);
            this.txtSexo.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.txtSexo.Name = "txtSexo";
            this.txtSexo.ReadOnly = true;
            this.txtSexo.Size = new System.Drawing.Size(52, 30);
            this.txtSexo.TabIndex = 151;
            // 
            // txtNasc
            // 
            this.txtNasc.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtNasc.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.txtNasc.Location = new System.Drawing.Point(48, 309);
            this.txtNasc.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.txtNasc.Name = "txtNasc";
            this.txtNasc.ReadOnly = true;
            this.txtNasc.Size = new System.Drawing.Size(193, 30);
            this.txtNasc.TabIndex = 149;
            this.txtNasc.TextChanged += new System.EventHandler(this.TxtNasc_TextChanged);
            // 
            // txtAlcunha
            // 
            this.txtAlcunha.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtAlcunha.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.txtAlcunha.Location = new System.Drawing.Point(48, 233);
            this.txtAlcunha.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.txtAlcunha.Name = "txtAlcunha";
            this.txtAlcunha.ReadOnly = true;
            this.txtAlcunha.Size = new System.Drawing.Size(351, 30);
            this.txtAlcunha.TabIndex = 145;
            // 
            // txtNome
            // 
            this.txtNome.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.txtNome.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.txtNome.Location = new System.Drawing.Point(165, 157);
            this.txtNome.Margin = new System.Windows.Forms.Padding(4);
            this.txtNome.Name = "txtNome";
            this.txtNome.ReadOnly = true;
            this.txtNome.Size = new System.Drawing.Size(356, 30);
            this.txtNome.TabIndex = 143;
            // 
            // botaoEliminarUtente
            // 
            this.botaoEliminarUtente.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.botaoEliminarUtente.BackColor = System.Drawing.Color.Coral;
            this.botaoEliminarUtente.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoEliminarUtente.ForeColor = System.Drawing.Color.White;
            this.botaoEliminarUtente.Location = new System.Drawing.Point(293, 407);
            this.botaoEliminarUtente.Margin = new System.Windows.Forms.Padding(4);
            this.botaoEliminarUtente.Name = "botaoEliminarUtente";
            this.botaoEliminarUtente.Size = new System.Drawing.Size(155, 52);
            this.botaoEliminarUtente.TabIndex = 162;
            this.botaoEliminarUtente.Text = "Eliminar utente";
            this.botaoEliminarUtente.UseVisualStyleBackColor = false;
            this.botaoEliminarUtente.Click += new System.EventHandler(this.BttnDelete_Click);
            // 
            // listBoxUtentes
            // 
            this.listBoxUtentes.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.listBoxUtentes.FormattingEnabled = true;
            this.listBoxUtentes.ItemHeight = 23;
            this.listBoxUtentes.Location = new System.Drawing.Point(12, 87);
            this.listBoxUtentes.Name = "listBoxUtentes";
            this.listBoxUtentes.Size = new System.Drawing.Size(473, 395);
            this.listBoxUtentes.TabIndex = 1;
            this.listBoxUtentes.SelectedIndexChanged += new System.EventHandler(this.ListBox1_SelectedIndexChanged);
            // 
            // botaoSair
            // 
            this.botaoSair.BackColor = System.Drawing.Color.Coral;
            this.botaoSair.FlatAppearance.BorderColor = System.Drawing.Color.Snow;
            this.botaoSair.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoSair.ForeColor = System.Drawing.Color.White;
            this.botaoSair.Location = new System.Drawing.Point(12, 21);
            this.botaoSair.Name = "botaoSair";
            this.botaoSair.Size = new System.Drawing.Size(132, 51);
            this.botaoSair.TabIndex = 70;
            this.botaoSair.Text = "Início";
            this.botaoSair.UseVisualStyleBackColor = false;
            this.botaoSair.Click += new System.EventHandler(this.Button2_Click);
            // 
            // buttonAddUtente
            // 
            this.buttonAddUtente.BackColor = System.Drawing.Color.MediumTurquoise;
            this.buttonAddUtente.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.buttonAddUtente.ForeColor = System.Drawing.Color.White;
            this.buttonAddUtente.Location = new System.Drawing.Point(150, 21);
            this.buttonAddUtente.Name = "buttonAddUtente";
            this.buttonAddUtente.Size = new System.Drawing.Size(216, 51);
            this.buttonAddUtente.TabIndex = 72;
            this.buttonAddUtente.Text = "Novo utente";
            this.buttonAddUtente.UseVisualStyleBackColor = false;
            this.buttonAddUtente.Click += new System.EventHandler(this.ButtonAddUtente_Click);
            // 
            // labelTotalUtentes
            // 
            this.labelTotalUtentes.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.labelTotalUtentes.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.labelTotalUtentes.Location = new System.Drawing.Point(13, 20);
            this.labelTotalUtentes.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.labelTotalUtentes.Name = "labelTotalUtentes";
            this.labelTotalUtentes.Size = new System.Drawing.Size(208, 32);
            this.labelTotalUtentes.TabIndex = 166;
            this.labelTotalUtentes.Text = "Número de utentes: ";
            // 
            // textTotalUtentes
            // 
            this.textTotalUtentes.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.textTotalUtentes.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textTotalUtentes.Location = new System.Drawing.Point(229, 20);
            this.textTotalUtentes.Margin = new System.Windows.Forms.Padding(4, 1, 4, 4);
            this.textTotalUtentes.Name = "textTotalUtentes";
            this.textTotalUtentes.Size = new System.Drawing.Size(45, 32);
            this.textTotalUtentes.TabIndex = 167;
            this.textTotalUtentes.Text = "2";
            this.textTotalUtentes.Click += new System.EventHandler(this.Label4_Click);
            // 
            // panel2
            // 
            this.panel2.Controls.Add(this.labelTotalUtentes);
            this.panel2.Controls.Add(this.textTotalUtentes);
            this.panel2.Location = new System.Drawing.Point(12, 488);
            this.panel2.Name = "panel2";
            this.panel2.Size = new System.Drawing.Size(473, 56);
            this.panel2.TabIndex = 168;
            // 
            // ListaUtentes
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1042, 556);
            this.Controls.Add(this.panel2);
            this.Controls.Add(this.buttonAddUtente);
            this.Controls.Add(this.botaoSair);
            this.Controls.Add(this.listBoxUtentes);
            this.Controls.Add(this.panel1);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "ListaUtentes";
            this.Text = "Utentes";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.panel2.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        

        #endregion

        private System.Windows.Forms.Panel panel1;
        internal System.Windows.Forms.TextBox txtID;
        internal System.Windows.Forms.Label Label11;
        internal System.Windows.Forms.Label Label9;
        internal System.Windows.Forms.Label Label5;
        internal System.Windows.Forms.Label Label2;
        internal System.Windows.Forms.Label Label1;
        internal System.Windows.Forms.TextBox txtSexo;
        internal System.Windows.Forms.TextBox txtNasc;
        internal System.Windows.Forms.TextBox txtAlcunha;
        internal System.Windows.Forms.TextBox txtNome;
        private System.Windows.Forms.Button botaoEliminarUtente;
        private System.Windows.Forms.ListBox listBoxUtentes;
        private System.Windows.Forms.Button botaoSair;
        private System.Windows.Forms.Button buttonAddUtente;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.Button botaoVerMais;
        internal System.Windows.Forms.Label labelTotalUtentes;
        internal System.Windows.Forms.Label textTotalUtentes;
        private System.Windows.Forms.Panel panel2;
    }
}