namespace ProjetoBD
{
    partial class ResponsabilidadeFuncionarioPopup
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(ResponsabilidadeFuncionarioPopup));
            this.buttonRemoveCuidado = new System.Windows.Forms.Button();
            this.buttonAddCuidadoFuncionario = new System.Windows.Forms.Button();
            this.listaCuidados = new System.Windows.Forms.ListBox();
            this.labelDetalhesAloj = new System.Windows.Forms.Label();
            this.comboBoxCuidados = new System.Windows.Forms.ComboBox();
            this.confirmarButton = new System.Windows.Forms.Button();
            this.panelAddCuidado = new System.Windows.Forms.Panel();
            this.buttonCancelarAddCuidado = new System.Windows.Forms.Button();
            this.textID = new System.Windows.Forms.Label();
            this.labelNoFuncionario = new System.Windows.Forms.Label();
            this.botaoSair = new System.Windows.Forms.Button();
            this.panelAddCuidado.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonRemoveCuidado
            // 
            this.buttonRemoveCuidado.BackColor = System.Drawing.Color.Coral;
            this.buttonRemoveCuidado.FlatAppearance.BorderColor = System.Drawing.Color.Snow;
            this.buttonRemoveCuidado.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.buttonRemoveCuidado.ForeColor = System.Drawing.Color.White;
            this.buttonRemoveCuidado.Location = new System.Drawing.Point(801, 118);
            this.buttonRemoveCuidado.Name = "buttonRemoveCuidado";
            this.buttonRemoveCuidado.Size = new System.Drawing.Size(216, 64);
            this.buttonRemoveCuidado.TabIndex = 100;
            this.buttonRemoveCuidado.Text = "Remover responsabilidade";
            this.buttonRemoveCuidado.UseVisualStyleBackColor = false;
            this.buttonRemoveCuidado.Click += new System.EventHandler(this.ButtonRemoveCuidado_Click);
            // 
            // buttonAddCuidadoFuncionario
            // 
            this.buttonAddCuidadoFuncionario.BackColor = System.Drawing.Color.MediumTurquoise;
            this.buttonAddCuidadoFuncionario.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.buttonAddCuidadoFuncionario.ForeColor = System.Drawing.Color.Transparent;
            this.buttonAddCuidadoFuncionario.Location = new System.Drawing.Point(564, 118);
            this.buttonAddCuidadoFuncionario.Name = "buttonAddCuidadoFuncionario";
            this.buttonAddCuidadoFuncionario.Size = new System.Drawing.Size(216, 64);
            this.buttonAddCuidadoFuncionario.TabIndex = 99;
            this.buttonAddCuidadoFuncionario.Text = "Adicionar responsabilidade";
            this.buttonAddCuidadoFuncionario.UseVisualStyleBackColor = false;
            this.buttonAddCuidadoFuncionario.Click += new System.EventHandler(this.ButtonAddCuidadoFuncionario_Click);
            // 
            // listaCuidados
            // 
            this.listaCuidados.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.listaCuidados.FormattingEnabled = true;
            this.listaCuidados.ItemHeight = 23;
            this.listaCuidados.Location = new System.Drawing.Point(47, 108);
            this.listaCuidados.Name = "listaCuidados";
            this.listaCuidados.Size = new System.Drawing.Size(453, 303);
            this.listaCuidados.TabIndex = 98;
            this.listaCuidados.SelectedIndexChanged += new System.EventHandler(this.ListaCuidados_SelectedIndexChanged);
            // 
            // labelDetalhesAloj
            // 
            this.labelDetalhesAloj.AutoSize = true;
            this.labelDetalhesAloj.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDetalhesAloj.ForeColor = System.Drawing.Color.DimGray;
            this.labelDetalhesAloj.Location = new System.Drawing.Point(66, 11);
            this.labelDetalhesAloj.Name = "labelDetalhesAloj";
            this.labelDetalhesAloj.Size = new System.Drawing.Size(322, 70);
            this.labelDetalhesAloj.TabIndex = 98;
            this.labelDetalhesAloj.Text = "Escolha a responsabilidade\r\na atribuir";
            this.labelDetalhesAloj.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            this.labelDetalhesAloj.UseMnemonic = false;
            this.labelDetalhesAloj.Click += new System.EventHandler(this.LabelDetalhesAloj_Click);
            // 
            // comboBoxCuidados
            // 
            this.comboBoxCuidados.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.comboBoxCuidados.FormattingEnabled = true;
            this.comboBoxCuidados.Location = new System.Drawing.Point(55, 94);
            this.comboBoxCuidados.Name = "comboBoxCuidados";
            this.comboBoxCuidados.Size = new System.Drawing.Size(349, 31);
            this.comboBoxCuidados.TabIndex = 99;
            this.comboBoxCuidados.SelectedIndexChanged += new System.EventHandler(this.ComboBoxCuidados_SelectedIndexChanged_1);
            // 
            // confirmarButton
            // 
            this.confirmarButton.BackColor = System.Drawing.Color.MediumTurquoise;
            this.confirmarButton.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.confirmarButton.ForeColor = System.Drawing.Color.Transparent;
            this.confirmarButton.Location = new System.Drawing.Point(115, 144);
            this.confirmarButton.Name = "confirmarButton";
            this.confirmarButton.Size = new System.Drawing.Size(216, 51);
            this.confirmarButton.TabIndex = 100;
            this.confirmarButton.Text = "Confirmar";
            this.confirmarButton.UseVisualStyleBackColor = false;
            this.confirmarButton.Click += new System.EventHandler(this.ConfirmarButton_Click);
            // 
            // panelAddCuidado
            // 
            this.panelAddCuidado.Controls.Add(this.confirmarButton);
            this.panelAddCuidado.Controls.Add(this.comboBoxCuidados);
            this.panelAddCuidado.Controls.Add(this.labelDetalhesAloj);
            this.panelAddCuidado.Location = new System.Drawing.Point(564, 213);
            this.panelAddCuidado.Name = "panelAddCuidado";
            this.panelAddCuidado.Size = new System.Drawing.Size(453, 198);
            this.panelAddCuidado.TabIndex = 101;
            // 
            // buttonCancelarAddCuidado
            // 
            this.buttonCancelarAddCuidado.BackColor = System.Drawing.Color.Coral;
            this.buttonCancelarAddCuidado.FlatAppearance.BorderColor = System.Drawing.Color.Snow;
            this.buttonCancelarAddCuidado.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.buttonCancelarAddCuidado.ForeColor = System.Drawing.Color.White;
            this.buttonCancelarAddCuidado.Location = new System.Drawing.Point(801, 118);
            this.buttonCancelarAddCuidado.Name = "buttonCancelarAddCuidado";
            this.buttonCancelarAddCuidado.Size = new System.Drawing.Size(216, 64);
            this.buttonCancelarAddCuidado.TabIndex = 102;
            this.buttonCancelarAddCuidado.Text = "Cancelar";
            this.buttonCancelarAddCuidado.UseVisualStyleBackColor = false;
            this.buttonCancelarAddCuidado.Click += new System.EventHandler(this.ButtonCancelarAddCuidado_Click);
            // 
            // textID
            // 
            this.textID.AutoSize = true;
            this.textID.BackColor = System.Drawing.Color.Transparent;
            this.textID.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textID.ForeColor = System.Drawing.Color.DimGray;
            this.textID.Location = new System.Drawing.Point(289, 28);
            this.textID.Name = "textID";
            this.textID.Size = new System.Drawing.Size(77, 46);
            this.textID.TabIndex = 174;
            this.textID.Text = "000";
            // 
            // labelNoFuncionario
            // 
            this.labelNoFuncionario.AutoSize = true;
            this.labelNoFuncionario.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelNoFuncionario.ForeColor = System.Drawing.Color.DimGray;
            this.labelNoFuncionario.Location = new System.Drawing.Point(39, 28);
            this.labelNoFuncionario.Name = "labelNoFuncionario";
            this.labelNoFuncionario.Size = new System.Drawing.Size(241, 46);
            this.labelNoFuncionario.TabIndex = 173;
            this.labelNoFuncionario.Text = "Empregado nº";
            // 
            // botaoSair
            // 
            this.botaoSair.BackColor = System.Drawing.Color.Coral;
            this.botaoSair.FlatAppearance.BorderColor = System.Drawing.Color.Snow;
            this.botaoSair.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.botaoSair.ForeColor = System.Drawing.Color.White;
            this.botaoSair.Location = new System.Drawing.Point(913, 32);
            this.botaoSair.Name = "botaoSair";
            this.botaoSair.Size = new System.Drawing.Size(104, 51);
            this.botaoSair.TabIndex = 175;
            this.botaoSair.Text = "Sair";
            this.botaoSair.UseVisualStyleBackColor = false;
            this.botaoSair.Click += new System.EventHandler(this.BotaoSair_Click);
            // 
            // ResponsabilidadeFuncionarioPopup
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(1066, 447);
            this.Controls.Add(this.botaoSair);
            this.Controls.Add(this.textID);
            this.Controls.Add(this.labelNoFuncionario);
            this.Controls.Add(this.buttonCancelarAddCuidado);
            this.Controls.Add(this.panelAddCuidado);
            this.Controls.Add(this.buttonRemoveCuidado);
            this.Controls.Add(this.buttonAddCuidadoFuncionario);
            this.Controls.Add(this.listaCuidados);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "ResponsabilidadeFuncionarioPopup";
            this.Text = "Responsabilidades";
            this.panelAddCuidado.ResumeLayout(false);
            this.panelAddCuidado.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion
        private System.Windows.Forms.Button buttonRemoveCuidado;
        private System.Windows.Forms.Button buttonAddCuidadoFuncionario;
        private System.Windows.Forms.ListBox listaCuidados;
        private System.Windows.Forms.Label labelDetalhesAloj;
        private System.Windows.Forms.ComboBox comboBoxCuidados;
        private System.Windows.Forms.Button confirmarButton;
        private System.Windows.Forms.Panel panelAddCuidado;
        private System.Windows.Forms.Button buttonCancelarAddCuidado;
        private System.Windows.Forms.Label textID;
        private System.Windows.Forms.Label labelNoFuncionario;
        private System.Windows.Forms.Button botaoSair;
    }
}