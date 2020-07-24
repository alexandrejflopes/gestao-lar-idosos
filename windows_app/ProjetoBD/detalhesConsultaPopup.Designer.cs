namespace ProjetoBD
{
    partial class detalhesConsultaPopup
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
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle5 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle6 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle7 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle8 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(detalhesConsultaPopup));
            this.titlePrescricao = new System.Windows.Forms.Label();
            this.textDataPresc = new System.Windows.Forms.Label();
            this.labelDataPresc = new System.Windows.Forms.Label();
            this.listaFarmacos = new System.Windows.Forms.DataGridView();
            this.nomeFarmaco = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nomeFarmaceutica = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.frequencia = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dataFimTratamento = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.label1 = new System.Windows.Forms.Label();
            this.linha_aloj = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.listaFarmacos)).BeginInit();
            this.SuspendLayout();
            // 
            // titlePrescricao
            // 
            this.titlePrescricao.AutoSize = true;
            this.titlePrescricao.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 20F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.titlePrescricao.ForeColor = System.Drawing.Color.DimGray;
            this.titlePrescricao.Location = new System.Drawing.Point(39, 31);
            this.titlePrescricao.Name = "titlePrescricao";
            this.titlePrescricao.Size = new System.Drawing.Size(272, 46);
            this.titlePrescricao.TabIndex = 92;
            this.titlePrescricao.Text = "Prescrição nº XX";
            // 
            // textDataPresc
            // 
            this.textDataPresc.AutoSize = true;
            this.textDataPresc.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.textDataPresc.Location = new System.Drawing.Point(104, 98);
            this.textDataPresc.Name = "textDataPresc";
            this.textDataPresc.Size = new System.Drawing.Size(37, 23);
            this.textDataPresc.TabIndex = 101;
            this.textDataPresc.Text = "827";
            // 
            // labelDataPresc
            // 
            this.labelDataPresc.AutoSize = true;
            this.labelDataPresc.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 10F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.labelDataPresc.Location = new System.Drawing.Point(43, 98);
            this.labelDataPresc.Name = "labelDataPresc";
            this.labelDataPresc.Size = new System.Drawing.Size(55, 23);
            this.labelDataPresc.TabIndex = 99;
            this.labelDataPresc.Text = "Data: ";
            // 
            // listaFarmacos
            // 
            dataGridViewCellStyle5.Font = new System.Drawing.Font("Yu Gothic", 10F, System.Drawing.FontStyle.Bold);
            this.listaFarmacos.AlternatingRowsDefaultCellStyle = dataGridViewCellStyle5;
            this.listaFarmacos.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.AllCells;
            this.listaFarmacos.BackgroundColor = System.Drawing.Color.WhiteSmoke;
            dataGridViewCellStyle6.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle6.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle6.Font = new System.Drawing.Font("Yu Gothic", 9F, System.Drawing.FontStyle.Bold);
            dataGridViewCellStyle6.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle6.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle6.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle6.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.listaFarmacos.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle6;
            this.listaFarmacos.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.listaFarmacos.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.nomeFarmaco,
            this.nomeFarmaceutica,
            this.frequencia,
            this.dataFimTratamento});
            dataGridViewCellStyle7.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle7.BackColor = System.Drawing.SystemColors.Window;
            dataGridViewCellStyle7.Font = new System.Drawing.Font("Yu Gothic", 10F);
            dataGridViewCellStyle7.ForeColor = System.Drawing.SystemColors.ControlText;
            dataGridViewCellStyle7.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle7.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle7.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.listaFarmacos.DefaultCellStyle = dataGridViewCellStyle7;
            this.listaFarmacos.Location = new System.Drawing.Point(47, 241);
            this.listaFarmacos.Name = "listaFarmacos";
            dataGridViewCellStyle8.Alignment = System.Windows.Forms.DataGridViewContentAlignment.MiddleLeft;
            dataGridViewCellStyle8.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle8.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F);
            dataGridViewCellStyle8.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle8.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle8.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle8.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.listaFarmacos.RowHeadersDefaultCellStyle = dataGridViewCellStyle8;
            this.listaFarmacos.RowHeadersWidth = 51;
            this.listaFarmacos.RowTemplate.DefaultCellStyle.Font = new System.Drawing.Font("Yu Gothic", 10F, System.Drawing.FontStyle.Bold);
            this.listaFarmacos.RowTemplate.Height = 24;
            this.listaFarmacos.Size = new System.Drawing.Size(706, 178);
            this.listaFarmacos.TabIndex = 102;
            // 
            // nomeFarmaco
            // 
            this.nomeFarmaco.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.Fill;
            this.nomeFarmaco.HeaderText = "Fármaco";
            this.nomeFarmaco.MinimumWidth = 6;
            this.nomeFarmaco.Name = "nomeFarmaco";
            // 
            // nomeFarmaceutica
            // 
            this.nomeFarmaceutica.HeaderText = "Farmacêutica";
            this.nomeFarmaceutica.MinimumWidth = 6;
            this.nomeFarmaceutica.Name = "nomeFarmaceutica";
            this.nomeFarmaceutica.Width = 138;
            // 
            // frequencia
            // 
            this.frequencia.HeaderText = "Frequência";
            this.frequencia.MinimumWidth = 6;
            this.frequencia.Name = "frequencia";
            this.frequencia.Width = 119;
            // 
            // dataFimTratamento
            // 
            this.dataFimTratamento.HeaderText = "Fim do tratamento";
            this.dataFimTratamento.MinimumWidth = 6;
            this.dataFimTratamento.Name = "dataFimTratamento";
            this.dataFimTratamento.Width = 160;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Font = new System.Drawing.Font("Yu Gothic UI Semibold", 16F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.label1.ForeColor = System.Drawing.Color.DimGray;
            this.label1.Location = new System.Drawing.Point(40, 185);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(133, 37);
            this.label1.TabIndex = 103;
            this.label1.Text = "Fármacos";
            // 
            // linha_aloj
            // 
            this.linha_aloj.AutoSize = true;
            this.linha_aloj.Font = new System.Drawing.Font("Yu Gothic UI Semilight", 10F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.linha_aloj.ForeColor = System.Drawing.Color.DarkGray;
            this.linha_aloj.Location = new System.Drawing.Point(43, 144);
            this.linha_aloj.Name = "linha_aloj";
            this.linha_aloj.Size = new System.Drawing.Size(717, 23);
            this.linha_aloj.TabIndex = 104;
            this.linha_aloj.Text = "_________________________________________________________________________________" +
    "____________________";
            this.linha_aloj.UseMnemonic = false;
            // 
            // detalhesConsultaPopup
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(8F, 16F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.White;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.linha_aloj);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.listaFarmacos);
            this.Controls.Add(this.textDataPresc);
            this.Controls.Add(this.labelDataPresc);
            this.Controls.Add(this.titlePrescricao);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "detalhesConsultaPopup";
            this.Text = "Detalhes da Consulta";
            ((System.ComponentModel.ISupportInitialize)(this.listaFarmacos)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Label titlePrescricao;
        private System.Windows.Forms.Label textDataPresc;
        private System.Windows.Forms.Label labelDataPresc;
        private System.Windows.Forms.DataGridView listaFarmacos;
        private System.Windows.Forms.DataGridViewTextBoxColumn nomeFarmaco;
        private System.Windows.Forms.DataGridViewTextBoxColumn nomeFarmaceutica;
        private System.Windows.Forms.DataGridViewTextBoxColumn frequencia;
        private System.Windows.Forms.DataGridViewTextBoxColumn dataFimTratamento;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Label linha_aloj;
    }
}