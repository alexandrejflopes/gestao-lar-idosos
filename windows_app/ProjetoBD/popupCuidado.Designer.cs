namespace ProjetoBD
{
    partial class popupCuidado
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(popupCuidado));
            this.labelDetalhesAloj = new System.Windows.Forms.Label();
            this.comboBoxCuidados = new System.Windows.Forms.ComboBox();
            this.confirmarButton = new System.Windows.Forms.Button();
            this.SuspendLayout();
            // 
            // labelDetalhesAloj
            // 
            this.labelDetalhesAloj.AutoSize = true;
            this.labelDetalhesAloj.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 15F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDetalhesAloj.ForeColor = System.Drawing.Color.DimGray;
            this.labelDetalhesAloj.Location = new System.Drawing.Point(46, 41);
            this.labelDetalhesAloj.Name = "labelDetalhesAloj";
            this.labelDetalhesAloj.Size = new System.Drawing.Size(355, 35);
            this.labelDetalhesAloj.TabIndex = 92;
            this.labelDetalhesAloj.Text = "Escolha o cuidado a adicionar";
            // 
            // comboBoxCuidados
            // 
            this.comboBoxCuidados.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            this.comboBoxCuidados.FormattingEnabled = true;
            this.comboBoxCuidados.Location = new System.Drawing.Point(52, 137);
            this.comboBoxCuidados.Name = "comboBoxCuidados";
            this.comboBoxCuidados.Size = new System.Drawing.Size(349, 31);
            this.comboBoxCuidados.TabIndex = 93;
            this.comboBoxCuidados.SelectedIndexChanged += new System.EventHandler(this.ComboBoxCuidados_SelectedIndexChanged);
            // 
            // confirmarButton
            // 
            this.confirmarButton.BackColor = System.Drawing.Color.MediumTurquoise;
            this.confirmarButton.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold);
            this.confirmarButton.ForeColor = System.Drawing.Color.Transparent;
            this.confirmarButton.Location = new System.Drawing.Point(115, 226);
            this.confirmarButton.Name = "confirmarButton";
            this.confirmarButton.Size = new System.Drawing.Size(216, 51);
            this.confirmarButton.TabIndex = 94;
            this.confirmarButton.Text = "Confirmar";
            this.confirmarButton.UseVisualStyleBackColor = false;
            this.confirmarButton.Click += new System.EventHandler(this.ConfirmarButton_Click);
            // 
            // popupCuidado
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(447, 332);
            this.Controls.Add(this.confirmarButton);
            this.Controls.Add(this.comboBoxCuidados);
            this.Controls.Add(this.labelDetalhesAloj);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "popupCuidado";
            this.Text = "Adicionar cuidado";
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label labelDetalhesAloj;
        private System.Windows.Forms.ComboBox comboBoxCuidados;
        private System.Windows.Forms.Button confirmarButton;
    }
}