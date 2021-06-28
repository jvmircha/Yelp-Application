import java.util.*;
import javax.swing.*;
import java.awt.*;
import javax.swing.border.Border;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.*;

public class yelpGUI {
   gui myGUI;
   public static void main(String[] args){
      yelpGUI myYelpGUI = new yelpGUI();
      myYelpGUI.myGUI = myYelpGUI.new gui();
      myYelpGUI.myGUI.display();
   }

   public class gui extends JFrame {
      JPanel panel = new JPanel();
      JPanel topPanel = new JPanel();
      JPanel bottomPanel = new JPanel();
      JPanel businessPanel = new JPanel();
      JPanel reviewPanel = new JPanel();
      JPanel resultPanel = new JPanel();
      JPanel userPanel = new JPanel();
      JPanel queryPanel = new JPanel();

      class CheckListItem {
         private String label;
         private boolean isSelected = false;

         public CheckListItem(String label) {
            this.label = label;
         }

         public boolean isSelected() {
            return isSelected;
         }

         public void setSelected(boolean isSelected) {
            this.isSelected = isSelected;
         }

         @Override
            public String toString() {
               return label;
            }
      }

      class CheckListRenderer extends JCheckBox implements ListCellRenderer<Object> {
         public Component getListCellRendererComponent(JList<?> list, Object value,
               int index, boolean isSelected, boolean hasFocus) {
            setEnabled(list.isEnabled());
            setSelected(((CheckListItem) value).isSelected());
            setFont(list.getFont());
            setBackground(list.getBackground());
            setForeground(list.getForeground());
            setText(value.toString());
            return this;
         }
      }

      public void populateCategory(JList list, String query, Connection connection) throws SQLException
      {
         DefaultListModel model = new DefaultListModel(); //create a new list model

         Statement statement = connection.createStatement();
         ResultSet resultSet = statement.executeQuery(query); //run your query

         while (resultSet.next()) //go through each row that your query returns
         {
            String itemCode = resultSet.getString("Business_Category_Id");
            model.addElement(itemCode); //add each item to the model
         }
         list.setModel(model);

         resultSet.close();
         statement.close();

      }

      public void addCheckbox(JCheckBox checkBox) {
         ListModel currentList = this.getModel();
         JCheckBox[] newList = new JCheckBox[currentList.getSize() + 1];
         for (int i = 0; i < currentList.getSize(); i++) {
            newList[i] = (JCheckBox) currentList.getElementAt(i);
         }
         newList[newList.length - 1] = checkBox;
         setListData(newList);
      }

      public void display(){
         panel.setLayout(new BoxLayout(panel, BoxLayout.PAGE_AXIS)); 
         topPanel.setLayout(new FlowLayout());
         bottomPanel.setLayout(new FlowLayout());
         panel.add(topPanel);
         panel.add(bottomPanel);
         topPanel.add(businessPanel);
         topPanel.add(reviewPanel);
         topPanel.add(resultPanel);
         bottomPanel.add(userPanel);
         bottomPanel.add(queryPanel);
         Border businessBorder = BorderFactory.createTitledBorder("");
         String spaces = "                   ";
         businessPanel.setLayout(new BoxLayout(businessPanel, BoxLayout.PAGE_AXIS));
         businessPanel.add(new JLabel(spaces + "Business" + spaces));  
         businessPanel.setBorder(businessBorder);

         JPanel businessBottomPanel = new JPanel();
         businessBottomPanel.setLayout(new FlowLayout());

         JPanel categoryPanel = new JPanel();
         categoryPanel.add(new JLabel("Category"));
         categoryPanel.setLayout(new BoxLayout(categoryPanel, BoxLayout.PAGE_AXIS));
         java.util.List<CheckListItem> categoryList = new ArrayList<>(10);
         for (int index = 0; index < 20; index++) {
            categoryList.add(new CheckListItem("List item" + index));
         }
         final JList<CheckListItem> jlistCategory = new JList<CheckListItem>(categoryList.toArray(new CheckListItem[categoryList.size()]));
         jlistCategory.setCellRenderer(new CheckListRenderer());
         JScrollPane categoryScrollPane = new JScrollPane();
         categoryScrollPane.setViewportView(jlistCategory);
         jlistCategory.setLayoutOrientation(JList.VERTICAL);
         categoryPanel.add(categoryScrollPane);

         categoryPanel.setBorder(businessBorder);
         businessBottomPanel.add(categoryPanel);

         JPanel subcategoryPanel = new JPanel();
         subcategoryPanel.add(new JLabel("Sub-Category"));

         subcategoryPanel.setLayout(new BoxLayout(subcategoryPanel, BoxLayout.PAGE_AXIS));
         java.util.List<CheckListItem> subcategoryList = new ArrayList<>(10);
         for (int index = 0; index < 20; index++) {
            subcategoryList.add(new CheckListItem("List item" + index));
         }
         final JList<CheckListItem> jlistSubcategory = new JList<CheckListItem>(subcategoryList.toArray(new CheckListItem[subcategoryList.size()]));
         jlistSubcategory.setCellRenderer(new CheckListRenderer());
         JScrollPane subcategoryScrollPane = new JScrollPane();
         subcategoryScrollPane.setViewportView(jlistSubcategory);
         jlistSubcategory.setLayoutOrientation(JList.VERTICAL);
         subcategoryPanel.add(subcategoryScrollPane);

         subcategoryPanel.setBorder(businessBorder);
         businessBottomPanel.add(subcategoryPanel);

         JPanel attributePanel = new JPanel();
         attributePanel.add(new JLabel("Atribute"));
         attributePanel.setBorder(businessBorder);
         businessBottomPanel.add(attributePanel);

         businessPanel.add(businessBottomPanel);

         reviewPanel.add(new JLabel(spaces + "Review" + spaces));
         reviewPanel.setBorder(businessBorder);

         resultPanel.add(new JLabel(spaces + "Result" + spaces));
         resultPanel.setBorder(businessBorder);

         userPanel.add(new JLabel(spaces + "User" + spaces));
         userPanel.setBorder(businessBorder);

         queryPanel.add(new JLabel(spaces + "Query" + spaces));
         queryPanel.setBorder(businessBorder);

         this.add(panel);
         this.setSize(800, 400);  
         this.setLocationRelativeTo(null);  
         this.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);  
         this.setVisible(true);  
      }
   }
}
