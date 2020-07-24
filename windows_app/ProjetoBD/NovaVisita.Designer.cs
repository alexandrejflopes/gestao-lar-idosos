namespace ProjetoBD
{
    partial class NovaVisita
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(NovaVisita));
            this.confirmarButton = new System.Windows.Forms.Button();
            this.comboBoxUtentes = new System.Windows.Forms.ComboBox();
            this.comboBoxVisitantes = new System.Windows.Forms.ComboBox();
            this.panel1 = new System.Windows.Forms.Panel();
            this.titleNovoUtente = new System.Windows.Forms.Label();
            this.groupBoxVisitante = new System.Windows.Forms.GroupBox();
            this.radioButtonNovoVisitante = new System.Windows.Forms.RadioButton();
            this.radioButtonVisitExistente = new System.Windows.Forms.RadioButton();
            this.labelSelecVisitante = new System.Windows.Forms.Label();
            this.label19 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.botaoCancelar = new System.Windows.Forms.Button();
            this.labelNomeVisitante = new System.Windows.Forms.Label();
            this.textNomeVisitante = new System.Windows.Forms.TextBox();
            this.labelCCVisitante = new System.Windows.Forms.Label();
            this.textCCVisitante = new System.Windows.Forms.TextBox();
            this.painelNovoVisitante = new System.Windows.Forms.Panel();
            this.panel1.SuspendLayout();
            this.groupBoxVisitante.SuspendLayout();
            this.painelNovoVisitante.SuspendLayout();
            this.SuspendLayout();
            // 
            // confirmarButton
            // 
            this.confirmarButton.BackColor = System.Drawing.Color.MediumTurquoise;
            this.confirmarButton.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.confirmarButton.ForeColor = System.Drawing.Color.Transparent;
            this.confirmarButton.Location = new System.Drawing.Point(59, 351);
            this.confirmarButton.Name = "confirmarButton";
            this.confirmarButton.Size = new System.Drawing.Size(159, 51);
            this.confirmarButton.TabIndex = 97;
            this.confirmarButton.Text = "Confirmar";
            this.confirmarButton.UseVisualStyleBackColor = false;
            this.confirmarButton.Click += new System.EventHandler(this.ConfirmarButton_Click);
            // 
            // comboBoxUtentes
            // 
            this.comboBoxUtentes.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.comboBoxUtentes.FormattingEnabled = true;
            this.comboBoxUtentes.Location = new System.Drawing.Point(59, 252);
            this.comboBoxUtentes.Name = "comboBoxUtentes";
            this.comboBoxUtentes.Size = new System.Drawing.Size(361, 31);
            this.comboBoxUtentes.TabIndex = 96;
            this.comboBoxUtentes.SelectedIndexChanged += new System.EventHandler(this.ComboBoxUtentes_SelectedIndexChanged);
            // 
            // comboBoxVisitantes
            // 
            this.comboBoxVisitantes.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.comboBoxVisitantes.FormattingEnabled = true;
            this.comboBoxVisitantes.Location = new System.Drawing.Point(521, 252);
            this.comboBoxVisitantes.Name = "comboBoxVisitantes";
            this.comboBoxVisitantes.Size = new System.Drawing.Size(427, 31);
            this.comboBoxVisitantes.TabIndex = 98;
            this.comboBoxVisitantes.SelectedIndexChanged += new System.EventHandler(this.ComboBoxVisitantes_SelectedIndexChanged);
            // 
            // panel1
            // 
            this.panel1.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(192)))), ((int)(((byte)(128)))));
            this.panel1.Controls.Add(this.titleNovoUtente);
            this.panel1.Dock = System.Windows.Forms.DockStyle.Top;
            this.panel1.Location = new System.Drawing.Point(0, 0);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(1020, 82);
            this.panel1.TabIndex = 158;
            // 
            // titleNovoUtente
            // 
            this.titleNovoUtente.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.titleNovoUtente.AutoSize = true;
            this.titleNovoUtente.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 26F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.titleNovoUtente.ForeColor = System.Drawing.Color.White;
            this.titleNovoUtente.Location = new System.Drawing.Point(358, 9);
            this.titleNovoUtente.Name = "titleNovoUtente";
            this.titleNovoUtente.Size = new System.Drawing.Size(304, 60);
            this.titleNovoUtente.TabIndex = 94;
            this.titleNovoUtente.Text = "Registar visita";
            this.titleNovoUtente.Click += new System.EventHandler(this.TitleNovoUtente_Click);
            // 
            // groupBoxVisitante
            // 
            this.groupBoxVisitante.Controls.Add(this.radioButtonNovoVisitante);
            this.groupBoxVisitante.Controls.Add(this.radioButtonVisitExistente);
            this.groupBoxVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Underline))));
            this.groupBoxVisitante.ForeColor = System.Drawing.Color.DimGray;
            this.groupBoxVisitante.Location = new System.Drawing.Point(501, 98);
            this.groupBoxVisitante.Name = "groupBoxVisitante";
            this.groupBoxVisitante.Size = new System.Drawing.Size(457, 101);
            this.groupBoxVisitante.TabIndex = 163;
            this.groupBoxVisitante.TabStop = false;
            this.groupBoxVisitante.Text = "O Visitante";
            // 
            // radioButtonNovoVisitante
            // 
            this.radioButtonNovoVisitante.AutoSize = true;
            this.radioButtonNovoVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.radioButtonNovoVisitante.ForeColor = System.Drawing.Color.Black;
            this.radioButtonNovoVisitante.Location = new System.Drawing.Point(248, 58);
            this.radioButtonNovoVisitante.Name = "radioButtonNovoVisitante";
            this.radioButtonNovoVisitante.Size = new System.Drawing.Size(136, 27);
            this.radioButtonNovoVisitante.TabIndex = 140;
            this.radioButtonNovoVisitante.TabStop = true;
            this.radioButtonNovoVisitante.Text = "Novo visitante";
            this.radioButtonNovoVisitante.UseVisualStyleBackColor = true;
            this.radioButtonNovoVisitante.CheckedChanged += new System.EventHandler(this.RadioButtonNovoVisitante_CheckedChanged);
            // 
            // radioButtonVisitExistente
            // 
            this.radioButtonVisitExistente.AutoSize = true;
            this.radioButtonVisitExistente.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.radioButtonVisitExistente.ForeColor = System.Drawing.Color.Black;
            this.radioButtonVisitExistente.Location = new System.Drawing.Point(20, 58);
            this.radioButtonVisitExistente.Name = "radioButtonVisitExistente";
            this.radioButtonVisitExistente.Size = new System.Drawing.Size(175, 27);
            this.radioButtonVisitExistente.TabIndex = 139;
            this.radioButtonVisitExistente.TabStop = true;
            this.radioButtonVisitExistente.Text = "Visitante recorrente";
            this.radioButtonVisitExistente.UseVisualStyleBackColor = true;
            this.radioButtonVisitExistente.CheckedChanged += new System.EventHandler(this.RadioButtonVisitExistente_CheckedChanged);
            // 
            // labelSelecVisitante
            // 
            this.labelSelecVisitante.AutoSize = true;
            this.labelSelecVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelSelecVisitante.Location = new System.Drawing.Point(517, 217);
            this.labelSelecVisitante.Name = "labelSelecVisitante";
            this.labelSelecVisitante.Size = new System.Drawing.Size(157, 23);
            this.labelSelecVisitante.TabIndex = 160;
            this.labelSelecVisitante.Text = "Selecionar visitante";
            // 
            // label19
            // 
            this.label19.AutoSize = true;
            this.label19.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, ((System.Drawing.FontStyle)((System.Drawing.FontStyle.Bold | System.Drawing.FontStyle.Underline))), System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label19.ForeColor = System.Drawing.Color.DimGray;
            this.label19.Location = new System.Drawing.Point(51, 137);
            this.label19.Name = "label19";
            this.label19.Size = new System.Drawing.Size(124, 46);
            this.label19.TabIndex = 169;
            this.label19.Text = "Utente";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.Location = new System.Drawing.Point(55, 204);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(207, 23);
            this.label1.TabIndex = 170;
            this.label1.Text = "Selecionar utente visitado";
            // 
            // botaoCancelar
            // 
            this.botaoCancelar.BackColor = System.Drawing.Color.Coral;
            this.botaoCancelar.FlatAppearance.BorderColor = System.Drawing.Color.Snow;
            this.botaoCancelar.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoCancelar.ForeColor = System.Drawing.Color.White;
            this.botaoCancelar.Location = new System.Drawing.Point(261, 351);
            this.botaoCancelar.Name = "botaoCancelar";
            this.botaoCancelar.Size = new System.Drawing.Size(159, 51);
            this.botaoCancelar.TabIndex = 172;
            this.botaoCancelar.Text = "Cancelar";
            this.botaoCancelar.UseVisualStyleBackColor = false;
            this.botaoCancelar.Click += new System.EventHandler(this.BotaoCancelar_Click);
            // 
            // labelNomeVisitante
            // 
            this.labelNomeVisitante.AutoSize = true;
            this.labelNomeVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNomeVisitante.Location = new System.Drawing.Point(16, 22);
            this.labelNomeVisitante.Name = "labelNomeVisitante";
            this.labelNomeVisitante.Size = new System.Drawing.Size(66, 23);
            this.labelNomeVisitante.TabIndex = 155;
            this.labelNomeVisitante.Text = "Nome: ";
            // 
            // textNomeVisitante
            // 
            this.textNomeVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textNomeVisitante.Location = new System.Drawing.Point(20, 64);
            this.textNomeVisitante.Name = "textNomeVisitante";
            this.textNomeVisitante.Size = new System.Drawing.Size(427, 30);
            this.textNomeVisitante.TabIndex = 156;
            this.textNomeVisitante.Text = "Nome Qualquer";
            // 
            // labelCCVisitante
            // 
            this.labelCCVisitante.AutoSize = true;
            this.labelCCVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelCCVisitante.Location = new System.Drawing.Point(16, 113);
            this.labelCCVisitante.Name = "labelCCVisitante";
            this.labelCCVisitante.Size = new System.Drawing.Size(153, 23);
            this.labelCCVisitante.TabIndex = 157;
            this.labelCCVisitante.Text = "Cartão de Cidadão";
            // 
            // textCCVisitante
            // 
            this.textCCVisitante.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.textCCVisitante.Location = new System.Drawing.Point(20, 155);
            this.textCCVisitante.Name = "textCCVisitante";
            this.textCCVisitante.Size = new System.Drawing.Size(160, 30);
            this.textCCVisitante.TabIndex = 158;
            this.textCCVisitante.Text = "951880111";
            // 
            // painelNovoVisitante
            // 
            this.painelNovoVisitante.Controls.Add(this.textCCVisitante);
            this.painelNovoVisitante.Controls.Add(this.labelCCVisitante);
            this.painelNovoVisitante.Controls.Add(this.textNomeVisitante);
            this.painelNovoVisitante.Controls.Add(this.labelNomeVisitante);
            this.painelNovoVisitante.Location = new System.Drawing.Point(501, 205);
            this.painelNovoVisitante.Name = "painelNovoVisitante";
            this.painelNovoVisitante.Size = new System.Drawing.Size(457, 221);
            this.painelNovoVisitante.TabIndex = 162;
            // 
            // NovaVisita
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1020, 480);
            this.Controls.Add(this.botaoCancelar);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.label19);
            this.Controls.Add(this.groupBoxVisitante);
            this.Controls.Add(this.painelNovoVisitante);
            this.Controls.Add(this.labelSelecVisitante);
            this.Controls.Add(this.panel1);
            this.Controls.Add(this.comboBoxVisitantes);
            this.Controls.Add(this.confirmarButton);
            this.Controls.Add(this.comboBoxUtentes);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "NovaVisita";
            this.Text = "Registar visita";
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            this.groupBoxVisitante.ResumeLayout(false);
            this.groupBoxVisitante.PerformLayout();
            this.painelNovoVisitante.ResumeLayout(false);
            this.painelNovoVisitante.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button confirmarButton;
        private System.Windows.Forms.ComboBox comboBoxUtentes;
        private System.Windows.Forms.ComboBox comboBoxVisitantes;
        private System.Windows.Forms.Panel panel1;
        private System.Windows.Forms.Label titleNovoUtente;
        private System.Windows.Forms.GroupBox groupBoxVisitante;
        private System.Windows.Forms.RadioButton radioButtonNovoVisitante;
        private System.Windows.Forms.RadioButton radioButtonVisitExistente;
        private System.Windows.Forms.Label labelSelecVisitante;
        private System.Windows.Forms.Label label19;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button botaoCancelar;
        private System.Windows.Forms.Label labelNomeVisitante;
        private System.Windows.Forms.TextBox textNomeVisitante;
        private System.Windows.Forms.Label labelCCVisitante;
        private System.Windows.Forms.TextBox textCCVisitante;
        private System.Windows.Forms.Panel painelNovoVisitante;
    }
}